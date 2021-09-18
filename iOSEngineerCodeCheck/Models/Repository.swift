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
    let full_name: String?
    let owner: Owner?
    let language: String?
    let forks_count: Int?
    let open_issues_count: Int?
    let watchers_count: Int?
    let stargazers_count: Int?
}

struct Owner: Decodable {
    let avatar_url: String?
}
