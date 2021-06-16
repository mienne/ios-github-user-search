import UIKit

extension UIViewController {

    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func insert(child: UIViewController, belowView: UIView) {
        addChild(child)
        view.insertSubview(child.view, belowSubview: belowView)
        child.didMove(toParent: self)
    }

    func remove(child: UIViewController) {
        if child.parent == nil { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
