import Combine
import Foundation
import CoreLocation

enum ListViewModelState {
    case loading
    case finished([Earthquake])
    case error(Swift.Error)
}

class ListViewModel: EarthquakeService {
    private var cancellables = Set<AnyCancellable>()
    
    enum Section { case quakes }
    
    @Published var state: ListViewModelState = .loading
    
    func loadList() {
        let receiveValueHandler: ([Earthquake]) -> Void = { [weak self] value in
            let earthquakes = value.sorted { $0.properties.mag > $1.properties.mag }
            self?.state = .finished(earthquakes)
        }
        
        let receiveCompletionHandler: (Subscribers.Completion<Swift.Error>) -> Void = { [weak self] completion in
            guard case .failure(let error) = completion else { return }
            self?.state = .error(error)
        }
        
        func resolveGeo(_ earthquakes: [Earthquake]) -> AnyPublisher<[Earthquake], Never> {
            Publishers.MergeMany(earthquakes.map { quake -> AnyPublisher<Earthquake, Never> in
                return CLGeocoder().reverseGeocodeLocationPublisher(quake)
            })
            .collect()
            .eraseToAnyPublisher()
        }
        
        earthquakeList(.aboveTwoWithHalf, .week)
            .flatMap { value -> AnyPublisher<[Earthquake], Never> in
                return resolveGeo(value.earthquakes)
            }
            .sink(receiveCompletion: receiveCompletionHandler, receiveValue: receiveValueHandler)
            .store(in: &cancellables)
    }
}
