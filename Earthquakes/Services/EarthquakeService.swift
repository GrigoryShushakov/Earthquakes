import Foundation
import Combine

protocol EarthquakeService {
    func earthquakeList() -> AnyPublisher<Earthquakes, Swift.Error>
}

extension EarthquakeService {
    func earthquakeList() -> AnyPublisher<Earthquakes, Swift.Error> {
        let request: NetworkRequest<Earthquakes> = .list(formatted: true,
                                                         north: 44.1,
                                                         south: -209.9,
                                                         east: -22.4,
                                                         west: 55.2,
                                                         username: "mkoppelman")
        return URLSession.shared.publisher(for: request)
    }
}
