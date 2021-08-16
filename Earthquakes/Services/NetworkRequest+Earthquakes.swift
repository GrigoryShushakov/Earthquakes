import Foundation

extension NetworkRequest where NetworkResponse == Earthquakes {
    static func list(formatted: Bool,
                     north: Double,
                     south: Double,
                     east: Double,
                     west: Double,
                     username: String) -> Self {
        
        NetworkRequest(baseUrl: URL(string: "http://api.geonames.org")!,
                       path: "earthquakesJSON",
                       method: .get([.init(name: "formatted", value: String(formatted)),
                                     .init(name: "north", value: String(north)),
                                     .init(name: "south", value: String(south)),
                                     .init(name: "east", value: String(east)),
                                     .init(name: "west", value: String(west)),
                                     .init(name: "username", value: username)]),
                       headers: ["Content-Type": "application/json"])
    }
}
