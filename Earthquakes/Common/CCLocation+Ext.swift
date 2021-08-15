import CoreLocation

extension CLLocation {
    func fetchCityAndRegion(completion: @escaping (_ city: String?, _ region:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality ?? $0?.first?.name, $0?.first?.administrativeArea, $1) }
    }
}
