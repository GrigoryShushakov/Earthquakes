import XCTest
@testable import Earthquakes

class ViewModelTests: XCTestCase {

    func testViewModel() throws {
        let viewModel = ListViewModelMock()
        let state = try XCTUnwrap(viewModel.state)
        guard case .loading = state else {
            XCTFail("Unexpected initial state")
            return
        }
        viewModel.loadList()
        let finState = try XCTUnwrap(viewModel.state)
        guard case .finished(_) = finState else {
            XCTFail("Unexpected initial state")
            return
        }
    }
}

class ListViewModelMock: ListViewModel {
    override func loadList() {
        state = .finished([])
    }
}
