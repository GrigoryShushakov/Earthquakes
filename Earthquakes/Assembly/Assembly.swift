import UIKit

final class Assembly {
    private let window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    lazy var mainRouter: MainRouter = MainRouter(
        window: window,
        assembly: self
    )
    
    var networkSession: NetworkService = NetworkSession()
}
