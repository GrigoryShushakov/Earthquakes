import Foundation

private let baseUrl = "http://api.geonames.org"
private let path = "earthquakesJSON"

enum EarthquakeEndpoint {
    case earthquakeList(formatted: Bool, north: Double, south: Double, east: Double, west: Double, username: String)
}

extension EarthquakeEndpoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .earthquakeList(let formatted, let north, let south, let east, let west, let username):
            guard var url = URL(string: baseUrl) else { preconditionFailure("Invalid URL format") }
            url.appendPathComponent(path)
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { preconditionFailure("Invalid URL format") }
            
            components.queryItems = [
                URLQueryItem(name: "formatted", value: String(formatted)),
                URLQueryItem(name: "north", value: String(north)),
                URLQueryItem(name: "south", value: String(south)),
                URLQueryItem(name: "east", value: String(east)),
                URLQueryItem(name: "west", value: String(west)),
                URLQueryItem(name: "username", value: username)
            ]
            guard let urlWithComponents = components.url else { preconditionFailure("Build url request failure") }
            let request = URLRequest(url: urlWithComponents)
            return request
        }
    }
}
