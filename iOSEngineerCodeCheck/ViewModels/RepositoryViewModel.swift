//
//  RepositoryViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by matsui kento on 2021/09/18.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift

struct RepositoryListViewModel {
    let repositoryVMList: [RepositoryViewModel]
}

extension RepositoryListViewModel {
    init(_ repositories: [Repository]) {
        self.repositoryVMList = repositories.compactMap(RepositoryViewModel.init)
    }
}

extension RepositoryListViewModel {
    func repositoryAt(_ index: Int) -> RepositoryViewModel {
        return self.repositoryVMList[index]
    }
}

struct RepositoryViewModel {
    
    let repository: Repository
    
    init(_ repository: Repository) {
        self.repository = repository
    }
}

extension RepositoryViewModel {
    
    var full_name: Observable<String> {
        return Observable<String>.just(repository.full_name ?? "")
    }
    
    var avatar_url: Observable<String> {
        return Observable<String>.just(repository.owner?.avatar_url ?? "")
    }
    
    var language: Observable<String> {
        return Observable<String>.just(repository.language ?? "")
    }
    
    var forks_count: Observable<Int> {
        return Observable<Int>.just(repository.forks_count ?? 00)
    }
    
    var open_issues_count: Observable<Int> {
        return Observable<Int>.just(repository.open_issues_count ?? 00)
    }
    
    var watchers_count: Observable<Int> {
        return Observable<Int>.just(repository.watchers_count ?? 00)
    }
    
    var stargazers_count: Observable<Int> {
        return Observable<Int>.just(repository.stargazers_count ?? 00)
    }
    
}
