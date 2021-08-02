import Foundation
import Combine

protocol EarthquakeService {
    var networkSession: NetworkService { get }
    func earthquakeList() -> AnyPublisher<Earthquakes, NetworkError>
}

extension EarthquakeService {
    func earthquakeList() -> AnyPublisher<Earthquakes, NetworkError> {
        return networkSession.request(with: EarthquakeEndpoint.earthquakeList(formatted: true, north: 44.1, south: -209.9, east: -22.4, west: 55.2, username: "mkoppelman"))
    }
}
