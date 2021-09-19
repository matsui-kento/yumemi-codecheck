//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class DetailRepositoryViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watchCountLabel: UILabel!
    @IBOutlet weak var ForkCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    var repositoryVM: RepositoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    // 選択されたレポジトリの詳細をUILabelとUIImageViewに反映させる
    private func setupBindings() {
        if let repositoryVM = self.repositoryVM {
            repositoryVM.full_name.bind { self.fullNameLabel.text = $0 }
            repositoryVM.language.bind { self.languageLabel.text = $0 }
            repositoryVM.watchers_count.bind { self.watchCountLabel.text = "\($0)" }
            repositoryVM.stargazers_count.bind { self.starCountLabel.text = "\($0)"  }
            repositoryVM.forks_count.bind { self.ForkCountLabel.text = "\($0)"  }
            repositoryVM.open_issues_count.bind { self.issuesCountLabel.text = "\($0)"  }
            repositoryVM.avatar_url.bind { self.avatarImageView.sd_setImage(with: URL(string: $0), completed: nil) }
        }
    }
}
