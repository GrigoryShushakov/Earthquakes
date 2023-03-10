import Foundation

enum MagnitudeFilter: String {
    case aboveOne = "1.0"
    case aboveTwoWithHalf = "2.5"
    case aboveFourWithHalf = "4.5"
}

enum PeriodFilter: String {
    case hour
    case day
    case week
    case month
}

struct Earthquakes: Decodable {
    let earthquakes: [Earthquake]
    enum CodingKeys: String, CodingKey {
            case earthquakes = "features"
        }
}

struct Earthquake: Decodable, Hashable {
    let geometry: Geometry
    var properties: Properties
    let id: String
}

struct Geometry: Decodable, Hashable {
    let coordinates: [Double]
}

struct Properties: Decodable, Hashable {
    let mag: Double
    let place: String
    var region: String?
    let time: Double
    let url: URL?
}
