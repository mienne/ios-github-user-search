//
//  SearchService.swift
//  GithubSearchRIBsReactorkit
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import RxSwift

protocol GithubServiceType {

    func searchUser(params: SearchUserParams) -> Single<Void>
}

class GithubService: GithubServiceType {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func searchUser(params: SearchUserParams) -> Single<Void> {
        return self.apiClient.request(GithubAPI.searchUser(params))
            .map(GitHubSearchUser.self)
            .map { _ in }
    }
}
