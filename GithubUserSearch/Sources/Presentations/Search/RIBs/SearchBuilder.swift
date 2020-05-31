//
//  SearchBuilder.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import RIBs

// MARK: - SearchDependency
protocol SearchDependency: Dependency { }

// MARK: - SearchComponent
final class SearchComponent: Component<SearchDependency>, DetailDependency {

    var useCase: SearchUseCase {
        return shared {
            let repository = DefaultSearchRepositoy(apiClient: APIClientManager(plugins: []))
            return DefaultSearchUseCase(repository: repository)
        }
    }

    override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol SearchBuildable: Buildable {

    func build(withListener listener: SearchListener) -> SearchRouting
}

final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {

    override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListener) -> SearchRouting {
        let component = SearchComponent(dependency: dependency)
        let viewController = SearchViewController.createViewController()
        let interactor = SearchInteractor(presenter: viewController, useCase: component.useCase)
        interactor.listener = listener
        let detailBuilder = DetailBuilder(dependency: component)
        return SearchRouter(interactor: interactor,
                            viewController: viewController,
                            detailBuilder: detailBuilder)
    }
}
