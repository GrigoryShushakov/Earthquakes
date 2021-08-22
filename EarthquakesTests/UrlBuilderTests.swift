import XCTest
@testable import Earthquakes

class UrlBuilderTests: XCTestCase {

    func testUrlBuilder() throws {
        let request: NetworkRequest<Earthquakes> = .list(formatted: true,
                                                         north: 44.1,
                                                         south: -209.9,
                                                         east: -22.4,
                                                         west: 55.2,
                                                         username: "mkoppelman")
        let url = try XCTUnwrap(request.urlRequest.url)
        XCTAssertEqual(url.absoluteString, "http://api.geonames.org/earthquakesJSON?formatted=true&north=44.1&south=-209.9&east=-22.4&west=55.2&username=mkoppelman")
    }
}
