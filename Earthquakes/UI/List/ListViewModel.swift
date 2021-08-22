import Combine
import Foundation
import CoreLocation

enum ListViewModelState {
    case loading
    case finished
    case error(Swift.Error)
}

final class ListViewModel: EarthquakeService {
    private var cancellables = Set<AnyCancellable>()
    
    enum Section { case quakes }
    
    @Published var earthquakes = [Earthquake]()
    @Published var state: ListViewModelState = .loading

    init() {
        loadList()
    }
    
    func loadList() {
        let receiveValueHandler: ([Earthquake]) -> Void = { [weak self] value in
            self?.earthquakes = value.sorted { $0.magnitude > $1.magnitude }
            self?.state = .finished
        }
        
        let receiveCompletionHandler: (Subscribers.Completion<Swift.Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error)
            case .finished:
                self?.state = .finished
            }
        }
        
        func resolveGeo(_ earthquakes: [Earthquake]) -> AnyPublisher<[Earthquake], Swift.Error> {
            Publishers.MergeMany(earthquakes.map { quake -> AnyPublisher<Earthquake, Swift.Error> in
                return CLGeocoder().reverseGeocodeLocationPublisher(quake)
            })
            .collect()
            .eraseToAnyPublisher()
        }
        
        earthquakeList()
            .flatMap { value -> AnyPublisher<[Earthquake], Swift.Error> in
                return resolveGeo(value.earthquakes)
            }
            .sink(receiveCompletion: receiveCompletionHandler, receiveValue: receiveValueHandler)
            .store(in: &cancellables)
    }
}
