import XCTest
@testable import Earthquakes

class UrlBuilderTests: XCTestCase {

    func testUrlBuilder() throws {
        let request: NetworkRequest<Earthquakes> = .list(magnitude: .aboveTwoWithHalf, period: .week)
        let url = try XCTUnwrap(request.urlRequest.url)
        XCTAssertEqual(url.absoluteString, "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_week.geojson?")
    }
}
