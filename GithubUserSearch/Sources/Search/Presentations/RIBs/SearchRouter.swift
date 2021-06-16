import RIBs

// MARK: - SearchInteractable
protocol SearchInteractable: Interactable, DetailListener {

    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
}

// MARK: - SearchViewControllable
protocol SearchViewControllable: ViewControllable {

    func present(viewControllable: ViewControllable, completion: (() -> Void)?)
}

// MARK: - Router
final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {

    private let detailBuilder: DetailBuildable
    private weak var childViewController: ViewableRouting?

    init(interactor: SearchInteractable, viewController: SearchViewControllable, detailBuilder: DetailBuilder) {
        self.detailBuilder = detailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension SearchRouter {

    func detachDetail() {
        if let child = childViewController {
            detachChild(child)
        }
    }

    func routeToDetail(_ user: User) {
        let detail = detailBuilder.build(withListener: interactor, user: user)
        childViewController = detail
        attachChild(detail)
        viewController.present(viewControllable: detail.viewControllable,
                               completion: nil)
    }
}
