//
//  SearchRepositoryMock.swift
//  GithubUserSearchTests
//
//  Created by hyeonjeong on 2020/06/01.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

@testable import GithubUserSearch

import RxSwift

final class SearchRepositoryMock: SearchRepositoy {

    func searchUsers(params: SearchUserParams) -> Single<Users> {
        let users = [
            User(name: "m", url: "https://api.github.com/users/m", imageUrl: ""),
            User(name: "mienne", url: "https://api.github.com/users/mienne", imageUrl: ""),
            User(name: "me", url: "https://api.github.com/users/me", imageUrl: "")
        ]
        return Single.just(Users(items: users, totalCount: users.count, incompleteResults: false))
    }
}
