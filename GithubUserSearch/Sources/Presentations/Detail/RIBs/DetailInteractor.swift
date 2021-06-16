import RIBs
import RxSwift

// MARK: - DetailRouting
protocol DetailRouting: ViewableRouting {

}

// MARK: - DetailPresentable
protocol DetailPresentable: Presentable {

    var listener: DetailPresentableListener? { get set }
}

// MARK: - DetailListener
protocol DetailListener: AnyObject {

    func detachDetail()
}

// MARK: - DetailInteractor
final class DetailInteractor: PresentableInteractor<DetailPresentable>, DetailInteractable, DetailPresentableListener {

    weak var router: DetailRouting?
    weak var listener: DetailListener?

    override init(presenter: DetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    func detach() {
        listener?.detachDetail()
    }
}
