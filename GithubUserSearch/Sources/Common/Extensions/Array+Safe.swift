//
//  Array+Safe.swift
//  GithubUserSearch
//
//  Created by hyeonjeong on 2020/06/05.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

extension Array {

    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
