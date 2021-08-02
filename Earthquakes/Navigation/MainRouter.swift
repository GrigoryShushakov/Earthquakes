import UIKit

final class MainRouter: Router {
    private let window: UIWindow?
    private let assembly: Assembly
    let navigation = UINavigationController()
    
    
    init(window: UIWindow?, assembly: Assembly) {
        self.assembly = assembly
        self.window = window
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func run() {
        navigation.navigationBar.prefersLargeTitles = true
        let router = ListRouter(navigation: navigation, assembly: assembly)
        router.run()
    }
}
