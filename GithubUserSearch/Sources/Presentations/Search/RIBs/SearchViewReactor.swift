//
//  SearchViewReactor.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import ReactorKit

// MARK: - Action
enum SearchViewAction {

    case routeToDetail(Int)
    case search
    case searchNext
    case typeKeyword(String)
}

// MARK: - State
struct SearchViewState {

    var count: Int = 0
    var page: Int = 1
    var isLoading: Bool = false
    var keyword: String = ""
    var users: [User] = []
    var sections: [SearchViewSection] {
        let sectionItems = users
            .map(UserCellReactor.init)
            .map(SearchViewSection.Item.user)
        return [SearchViewSection(identity: .users, items: sectionItems)]
    }
}

// MARK: - Reactor
typealias SearchViewReactor = (
    state: Observable<SearchViewState>,
    action: ActionSubject<SearchViewAction>
)
