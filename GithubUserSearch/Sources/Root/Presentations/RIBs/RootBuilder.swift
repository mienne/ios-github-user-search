import RIBs

// MARK: - RootDependency
protocol RootDependency: Dependency { }

// MARK: - RootComponent
final class RootComponent: Component<RootDependency>, SearchDependency {

    private let rootViewController: RootViewController

    init(dependency: RootDependency, viewController: RootViewController) {
        self.rootViewController = viewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol RootBuildable: Buildable {

    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency,
                                      viewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        let searchBuilder = SearchBuilder(dependency: component)
        let router = RootRouter(interactor: interactor,
                                viewController: viewController,
                                searchBuilder: searchBuilder)
        return (router, interactor)
    }
}
