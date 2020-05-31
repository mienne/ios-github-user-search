//
//  AppComponent.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation
import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
