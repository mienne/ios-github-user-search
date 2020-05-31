//
//  SearchRepositoy.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import RxSwift
import Moya

protocol SearchRepositoy: class {

    func searchUsers(params: SearchUserParams) -> Single<Users>
}

final class DefaultSearchRepositoy: SearchRepositoy {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func searchUsers(params: SearchUserParams) -> Single<Users> {
        return self.apiClient.request(GithubService.searchUser(params))
                .map(Users.self)
    }
}
