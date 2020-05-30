//
//  GitHubUser.swift
//  GithubSearchRIBsReactorkit
//
//  Created by hyeonjeong on 2020/05/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct GitHubUser {

    let name: String
    let url: String
    let imageUrl: String
}

// MARK: - Decodable
extension GitHubUser: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case url = "url"
        case imageUrl =  "avatar_url"
    }
}
