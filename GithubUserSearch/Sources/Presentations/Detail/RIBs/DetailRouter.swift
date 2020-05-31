//
//  DetailRouter.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/06/05.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import RIBs

// MARK: - DetailInteractable
protocol DetailInteractable: Interactable {

    var router: DetailRouting? { get set }
    var listener: DetailListener? { get set }
}

// MARK: - DetailViewControllable
protocol DetailViewControllable: ViewControllable { }

// MARK: - DetailRouter
final class DetailRouter: ViewableRouter<DetailInteractable, DetailViewControllable>, DetailRouting {

    override init(interactor: DetailInteractable, viewController: DetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
