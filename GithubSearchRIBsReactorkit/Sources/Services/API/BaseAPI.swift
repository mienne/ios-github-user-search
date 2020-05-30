//
//  BaseAPI.swift
//  GithubSearchRIBsReactorkit
//
//  Created by hyeonjeong on 2020/05/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import MoyaSugar

protocol BaseAPI: SugarTargetType, Hashable { }

extension BaseAPI {

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var headers: [String: String]? {
        return [
            "Authorization": "token 542c12c91573b1442a38d74afe8f87bd525eceb0",
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/vnd.github.v3+json"
        ]
    }

    var sampleData: Data {
        return Data()
    }
}
