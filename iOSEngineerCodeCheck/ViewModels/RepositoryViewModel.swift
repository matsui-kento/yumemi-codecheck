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
        // compactMapでnilになる値を排除して、RepositoryViewModelのリストに変換する
        self.repositoryVMList = repositories.compactMap(RepositoryViewModel.init)
    }
}

extension RepositoryListViewModel {
    // RepositoryViewModelのリストから特定のRepositoryViewModelを取り出す。
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

// RepositoryViewModel.(変数名)で値を返す
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
