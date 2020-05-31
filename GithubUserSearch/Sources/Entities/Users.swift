//
//  Users.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct Users {

    var items: [User]
    var totalCount: Int?
    var incompleteResults: Bool
}

// MARK: - Decodable
extension Users: Decodable {

    private enum CodingKeys: String, CodingKey {
        case items =  "items"
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
}
