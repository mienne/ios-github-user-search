import UIKit
import RIBs

extension UINavigationController: ViewControllable {

    public var uiviewController: UIViewController { return self }

    public convenience init(viewControllable: ViewControllable) {
        self.init(rootViewController: viewControllable.uiviewController)
    }
}
