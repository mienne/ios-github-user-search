import RIBs
import RxSwift
import UIKit

// MARK: - RootPresentableListener
protocol RootPresentableListener: AnyObject { }

// MARK: - RootViewController
final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?

    private var currentViewController: ViewControllable?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
}

// MARK: - Override
extension RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}

// MARK: - Public
extension RootViewController {

    func replace(toVC: ViewControllable?) {
        if let toVC = toVC?.uiviewController {
            self.add(child: toVC)
        }

        let fromVC = self.currentViewController?.uiviewController
        if let fromVC = fromVC {
            self.remove(child: fromVC)
        }

        self.currentViewController = toVC
    }
}
