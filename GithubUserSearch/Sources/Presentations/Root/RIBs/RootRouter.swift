import RIBs

// MARK: - RootInteractable
protocol RootInteractable: Interactable, SearchListener {

    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

// MARK: - RootViewControllable
protocol RootViewControllable: ViewControllable {

    func replace(toVC: ViewControllable?)
}

// MARK: - Rounter
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let searchBuilder: SearchBuildable

    init(interactor: RootInteractable, viewController: RootViewControllable, searchBuilder: SearchBuilder) {
        self.searchBuilder = searchBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        routeToSearch()
    }
}

private extension RootRouter {

    func routeToSearch() {
        let search = searchBuilder.build(withListener: interactor)
        self.attachChild(search)
        let navigationController = UINavigationController(rootViewController: search.viewControllable.uiviewController)
        viewController.replace(toVC: navigationController)
    }
}
