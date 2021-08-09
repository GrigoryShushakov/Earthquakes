import UIKit

class BaseViewController<T, V: UIView>: UIViewController {
    
    private(set) var viewModel: T
    var contentView: V { return view as! V }
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view = V()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        view.backgroundColor = UIColor.systemBackground
    }
}
