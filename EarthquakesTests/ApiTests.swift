import XCTest
import Combine
@testable import Earthquakes

class ApiTests: XCTestCase {

    func testApi() throws {
        let expectation = XCTestExpectation(description: "Download quakes")
        var cancellables = Set<AnyCancellable>()
        let service = ServiceMock()
        service.earthquakeList(.aboveTwoWithHalf, .week).sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .finished:
                expectation.fulfill()
            }
        } receiveValue: { value in
            XCTAssertFalse(value.earthquakes.isEmpty)
            expectation.fulfill()
        }
        .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}

class ServiceMock: EarthquakeService { }
