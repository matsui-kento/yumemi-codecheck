//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift

class SearchRepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    private var repositoryListVM: RepositoryListViewModel!
    
    var repository: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String!
    var url: String!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
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
            let detailRepositoryVC = segue.destination as! DetailRepositoryViewController
            detailRepositoryVC.searchRepositoryVC = self
        }
        
    }
}

extension SearchRepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repository[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "toDetailVC", sender: self)
        
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
