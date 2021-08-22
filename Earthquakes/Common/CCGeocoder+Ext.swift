import CoreLocation
import Combine

extension CLGeocoder {
    func reverseGeocodeLocationPublisher(_ earthquake: Earthquake) -> AnyPublisher<Earthquake, Swift.Error> {
        Future<Earthquake, Error> { promise in
            let location = CLLocation(latitude: earthquake.lat, longitude: earthquake.lng)
            self.reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first else {
                    return promise(.failure(error ?? CLError(.geocodeFoundNoResult)))
                }
                var quake = earthquake
                quake.city = placemark.locality ?? placemark.name
                quake.region = placemark.administrativeArea
                return promise(.success(quake))
            }
        }
        .eraseToAnyPublisher()
    }
}
