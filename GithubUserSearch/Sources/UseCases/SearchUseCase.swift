//
//  SearchUseCase.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import RxSwift

protocol SearchUseCase: class {

    func searchUsers(query: String, page: Int, per: Int) -> Single<Users>
}

final class DefaultSearchUseCase: SearchUseCase {

    private let repository: SearchRepositoy

    init(repository: SearchRepositoy) {
        self.repository = repository
    }

    func searchUsers(query: String, page: Int, per: Int) -> Single<Users> {
        let params = SearchUserParams(query: query, page: page, perPage: per)
        return repository.searchUsers(params: params)
    }
}
