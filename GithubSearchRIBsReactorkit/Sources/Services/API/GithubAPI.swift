//
//  GithubAPI.swift
//  GithubSearchRIBsReactorkit
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import MoyaSugar

enum GithubAPI {

    case searchUser(SearchUserParams)
}

extension GithubAPI: BaseAPI {

    var route: Route {
        switch self {
        case .searchUser:
            return .get("/search/users")
        }
    }

    var parameters: Parameters? {
        switch self {
        case .searchUser(let params):
            return JSONEncoding() => params.asDictionary()
        }
    }
}
