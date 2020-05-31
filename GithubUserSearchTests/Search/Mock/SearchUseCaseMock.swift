//
//  SearchUseCaseMock.swift
//  GithubUserSearchTests
//
//  Created by hyeonjeong on 2020/06/01.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

@testable import GithubUserSearch

import RxSwift

final class SearchUseCaseMock: SearchUseCase {

    var searchUserHandler: ((SearchUserParams) -> Single<Users>)?
    var searchUserCallCount: Int = 0

    init() {}

    func searchUsers(query: String, page: Int, per: Int) -> Single<Users> {
        self.searchUserCallCount += 1
        let params = SearchUserParams(query: query, page: page, perPage: per)
        return (self.searchUserHandler?(params) ?? .never())
    }
}
