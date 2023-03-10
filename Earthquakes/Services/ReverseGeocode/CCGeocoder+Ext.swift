import CoreLocation
import Combine

extension CLGeocoder {
    func reverseGeocodeLocationPublisher(_ earthquake: Earthquake) -> AnyPublisher<Earthquake, Never> {
        Future<Earthquake, Never> { promise in
            let location = CLLocation(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0])
            self.reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first else {
                    return promise(.success(earthquake))
                }
                var quake = earthquake
                quake.properties.region = placemark.locality ?? placemark.name
                return promise(.success(quake))
            }
        }
        .eraseToAnyPublisher()
    }
}
