//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchRepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    private var repositoryListVM: RepositoryListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func searchRepository(by word: String) {
        
        guard let wordEncode = word.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForGitHubAPI(word: wordEncode) else { return }
        
        let resource = Resource<RepositoryList>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { repositoryList in
                
                guard let repositories = repositoryList.items else { return }
                self.repositoryListVM = RepositoryListViewModel(repositories)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let detailRepositoryVC = segue.destination as? DetailRepositoryViewController,
                  let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let repositoryVM = self.repositoryListVM.repositoryAt(indexPath.row)
            detailRepositoryVC.repositoryVM = repositoryVM
        }
    }
}

extension SearchRepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoryListVM == nil ? 0 : self.repositoryListVM.repositoryVMList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell else {
            fatalError("RepositoryTableViewCell is not found")
        }
        
        let repositoryVM = repositoryListVM.repositoryAt(indexPath.row)
        
        repositoryVM.full_name
            .asDriver(onErrorJustReturn: "")
            .drive(cell.fullNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let word = searchBar.text else { return }
        
        if !word.isEmpty {
            searchRepository(by: word)
        }
    }
}
