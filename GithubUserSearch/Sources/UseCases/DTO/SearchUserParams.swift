//
//  SearchUserParams.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct SearchUserParams: Encodable, Hashable {

    let query: String
    let page: Int
    let perPage: Int

    private enum CodingKeys: String, CodingKey {

        case query = "q"
        case page
        case perPage = "per_page"
    }
}
