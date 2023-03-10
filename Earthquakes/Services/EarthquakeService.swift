import Foundation
import Combine

protocol EarthquakeService {
    func earthquakeList(_ magnitude: MagnitudeFilter, _ period: PeriodFilter) -> AnyPublisher<Earthquakes, Swift.Error>
}

extension EarthquakeService {
    func earthquakeList(_ magnitude: MagnitudeFilter, _ period: PeriodFilter) -> AnyPublisher<Earthquakes, Swift.Error> {
        let request: NetworkRequest<Earthquakes> = .list(magnitude: magnitude, period: period)
        return URLSession.shared.publisher(for: request)
    }
}
