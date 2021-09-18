//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watchCountLabel: UILabel!
    @IBOutlet weak var ForkCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    var searchRepositoryVC: SearchRepositoryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = searchRepositoryVC.repository[searchRepositoryVC.index]
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starCountLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchCountLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        ForkCountLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesCountLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getavatarImage()
        
    }
    
    func getavatarImage(){
        
        let repository = searchRepositoryVC.repository[searchRepositoryVC.index]
        
        fullNameLabel.text = repository["full_name"] as? String
        
        if let owner = repository["owner"] as? [String: Any] {
            if let avatarImageURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: avatarImageURL)!) { (data, response, error) in
                    let image = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }.resume()
            }
        }
        
    }
    
}
