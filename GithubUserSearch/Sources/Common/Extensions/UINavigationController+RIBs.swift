//
//  UINavigationController+RIBs.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import UIKit
import RIBs

extension UINavigationController: ViewControllable {

    public var uiviewController: UIViewController { return self }

    public convenience init(viewControllable: ViewControllable) {
        self.init(rootViewController: viewControllable.uiviewController)
    }
}
