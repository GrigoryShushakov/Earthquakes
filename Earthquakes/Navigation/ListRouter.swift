import UIKit

final class ListRouter: Router {
    let navigation: UINavigationController
    let assembly: Assembly
    
    init(navigation: UINavigationController, assembly: Assembly) {
        self.navigation = navigation
        self.assembly = assembly
    }
    
    func run() {
        let viewModel = ListViewModel(networkSession: assembly.networkSession)
        let listController = ListViewController(viewModel: viewModel)
        listController.title = NSLocalizedString("Earthquakes", comment: "")
        listController.router = self
        navigation.setViewControllers([listController], animated: true)
    }
    
    func quakeDetails(_ earthquake: Earthquake) {
        let quakeDetailsRouter = DetailsRouter(navigation: navigation, assembly: assembly, earthquake: earthquake)
        quakeDetailsRouter.run()
    }
}
