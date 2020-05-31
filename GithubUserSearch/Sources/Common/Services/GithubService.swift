//
//  GithubService.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Moya

enum GithubService {

    case searchUser(SearchUserParams)
}

extension GithubService: BaseService {

    var path: String {
        switch self {
        case .searchUser: return "/search/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .searchUser: return .get
        }
    }
    var task: Task {
        switch self {
        case .searchUser(let params):
            return .requestParameters(
                parameters: params.asDictionary(),
                encoding: URLEncoding.default
            )
        }
    }
}
