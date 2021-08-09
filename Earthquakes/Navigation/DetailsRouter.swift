import UIKit
import MapKit

final class DetailsRouter: Router {
    let navigation: UINavigationController
    let assembly: Assembly
    let earthquake: Earthquake
    
    init(navigation: UINavigationController, assembly: Assembly, earthquake: Earthquake) {
        self.navigation = navigation
        self.assembly = assembly
        self.earthquake = earthquake
    }
    
    func run() {
        let detailsViewModel = DetailsViewModel(earthquake: earthquake)
        let detailsController = DetailsViewController(viewModel: detailsViewModel)
        detailsController.title = NSLocalizedString("Earthquake location", comment: "")
        navigation.pushViewController(detailsController, animated: true)
    }
}
