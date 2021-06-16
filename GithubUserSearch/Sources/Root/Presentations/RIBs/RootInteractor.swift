import RIBs
import RxSwift

// MARK: - RootRouting
protocol RootRouting: ViewableRouting { }

// MARK: - RootPresentable
protocol RootPresentable: Presentable {

    var listener: RootPresentableListener? { get set }
}

// MARK: - RootListener
protocol RootListener: AnyObject { }

// MARK: - Interactor
final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension RootInteractor: URLHandler {

    func handle(_ url: URL) { }
}
