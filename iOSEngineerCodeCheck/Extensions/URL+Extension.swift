//
//  URL+Extension.swift
//  iOSEngineerCodeCheck
//
//  Created by matsui kento on 2021/09/18.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

extension URL {
    // searchBarに入力された値を挿入して、GitHub APIに送るURLを作成する
    static func urlForGitHubAPI(word: String) -> URL? {
        return URL(string: "https://api.github.com/search/repositories?q=\(word)")
    }
}
