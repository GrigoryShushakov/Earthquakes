import UIKit

class BaseViewController<T>: UIViewController {
    
    private(set) var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        view.backgroundColor = UIColor.systemBackground
    }
}
