//
//  Encodable+Dictionary.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/05/31.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

extension Encodable {

    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [: ]
        }

        return dictionary
    }
}
