import Foundation

extension NetworkRequest where NetworkResponse == Earthquakes {
    static func list(magnitude: MagnitudeFilter,
                     period: PeriodFilter) -> Self {
        
        NetworkRequest(baseUrl: URL(string: "https://earthquake.usgs.gov")!,
                       path: "earthquakes/feed/v1.0/summary/\(magnitude.rawValue)_\(period).geojson",
                       method: .get([]),
                       headers: ["Content-Type": "application/json"])
    }
}
