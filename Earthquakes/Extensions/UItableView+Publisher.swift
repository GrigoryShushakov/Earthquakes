import UIKit
import Combine

public extension UITableView {
    /// Combine wrapper for `tableView(_:didSelectRowAt:)`
    var didSelectRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    private var delegateProxy: TableViewDelegateProxy {
        .createDelegateProxy(for: self)
    }
}

@available(iOS 13.0, *)
private class TableViewDelegateProxy: DelegateProxy, UITableViewDelegate, DelegateProxyType {
    func setDelegate(to object: UITableView) {
        object.delegate = self
    }
}
#endif
