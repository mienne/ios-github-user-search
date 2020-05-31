//
//  SearchInteractor.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import ReactorKit
import RIBs
import RxSwift

// MARK: - SearchRouting
protocol SearchRouting: ViewableRouting {

    func detachDetail()
    func routeToDetail(_ user: User)
}

// MAR: - SearchPresentable
protocol SearchPresentable: Presentable {

    var listener: SearchPresentableListener? { get set }
}

// MARK: - SearchListener
protocol SearchListener: class { }

// MARK: - Interactor
final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable, SearchPresentableListener {

    typealias State = SearchViewState
    typealias Action = SearchViewAction

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    let initialState: State = State()

    private let useCase: SearchUseCase

    init(presenter: SearchPresentable, useCase: SearchUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

// MARK: - Reactor
extension SearchInteractor: Reactor {

    enum Mutation {

        case setLoading(Bool)
        case setKeyword(String)
        case setUsers(Users)
    }

    func mutate(action: SearchViewAction) -> Observable<Mutation> {
        switch action {
        case .routeToDetail(let index):
            if let user = self.currentState.users[safe: index] {
                router?.routeToDetail(user)
            }
            return .empty()
        case .search:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                search(),
                Observable.just(Mutation.setLoading(false))
            ])
        case .searchNext:
            return .empty()
        case .typeKeyword(let keyword):
            return Observable.just(Mutation.setKeyword(keyword))
        }
    }

    func reduce(state: SearchViewState, mutation: Mutation) -> SearchViewState {
        var newState = state
        switch mutation {
        case .setKeyword(let keyword):
            newState.keyword = keyword
        case .setLoading(let loading):
            newState.isLoading = loading
        case .setUsers(let result):
            newState.users = result.items
            newState.count = result.totalCount ?? 0
        }
        return newState
    }
}

// MARK: - DetailInteractor
extension SearchInteractor {

    func detachDetail() {
        router?.detachDetail()
    }
}

// MARK: - Private: Searching
private extension SearchInteractor {

    func search() -> Observable<Mutation> {
        return self.useCase.searchUsers(query: self.currentState
            .keyword, page: self.currentState.page, per: 30)
            .asObservable()
            .flatMap { result -> Observable<Mutation> in
                Observable.just(Mutation.setUsers(result))
            }
            .catchError {  _ -> Observable<Mutation> in
                Observable.just(Mutation.setLoading(false))
            }
    }
}
