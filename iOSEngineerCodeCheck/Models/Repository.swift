//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by matsui kento on 2021/09/18.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct RepositoryList: Decodable {
    let items: [Repository]?
}

struct Repository: Decodable {
    let full_name: String?        // アカウント名 / リポジトリ名
    let owner: Owner?             // アバター写真のURLの文字列
    let language: String?         // 言語
    let forks_count: Int?         // Forkの数
    let open_issues_count: Int?   // 開いているissueの数
    let watchers_count: Int?      // watchの数
    let stargazers_count: Int?    // starの数
}

struct Owner: Decodable {
    let avatar_url: String?       // アバター写真のURLの文字列
}
