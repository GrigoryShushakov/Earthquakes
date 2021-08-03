import Combine
import Foundation

enum ListViewModelState {
    case loading
    case finished
    case error(NetworkError)
}

final class ListViewModel: EarthquakeService {
    var networkSession: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    enum Section { case quakes }
    
    @Published var earthquakes = [Earthquake]()
    @Published var state: ListViewModelState = .loading

    init(networkSession: NetworkService) {
        self.networkSession = networkSession
        loadList()
    }
    
    func loadList() {
        let receiveValueHandler: (Earthquakes) -> Void = { [weak self] value in
            self?.earthquakes = value.earthquakes
            self?.state = .finished
        }
        
        let receiveCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error)
            case .finished:
                self?.state = .finished
            }
        }
        
        earthquakeList()
            .sink(receiveCompletion: receiveCompletionHandler, receiveValue: receiveValueHandler)
            .store(in: &cancellables)
    }
}
