//
//  DetailBuilder.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/06/05.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import RIBs

// MARK: - DetailDependency
protocol DetailDependency: Dependency {

}

// MARK: - DetailComponent
final class DetailComponent: Component<DetailDependency> {

}

// MARK: - DetailBuilder
protocol DetailBuildable: Buildable {

    func build(withListener listener: DetailListener, user: User) -> DetailRouting
}

final class DetailBuilder: Builder<DetailDependency> {

    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }
}

extension DetailBuilder: DetailBuildable {

    func build(withListener listener: DetailListener, user: User) -> DetailRouting {
//        let component = DetailComponent(dependency: dependency)
        let viewController = DetailViewController.create(user)
        let interactor = DetailInteractor(presenter: viewController)
        interactor.listener = listener
        return DetailRouter(interactor: interactor, viewController: viewController)
    }
}
