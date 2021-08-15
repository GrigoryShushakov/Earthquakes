import CoreLocation

struct Earthquake: Decodable, Hashable {
    let datetime: String
    let magnitude: Double
    let lat: Double
    let lng: Double
    let depth: Double
    let src: String
    let eqid: String
    var city: String?
    var region: String?
}

struct Earthquakes: Decodable {
    let earthquakes: [Earthquake]
}

extension Earthquake {
    func fetchCityAndRegion(completion: @escaping (_ city: String?, _ region:  String?, _ error: Error?) -> ()) {
        let location = CLLocation(latitude: self.lat, longitude: self.lng)
        location.fetchCityAndRegion { city, region, error in
            completion(city, region, error)
        }
    }
}
