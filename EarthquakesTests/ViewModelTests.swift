import XCTest
@testable import Earthquakes

class ViewModelTests: XCTestCase {

    func testViewModel() throws {
        let viewModel = ListViewModel(networkSession: NetworkSession())
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.state)
        XCTAssert(viewModel.earthquakes == [])
    }
}
