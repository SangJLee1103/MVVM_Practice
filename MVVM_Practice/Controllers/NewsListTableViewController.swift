//
//  NewsListTableViewController.swift
//  MVVM_Practice
//
//  Created by 이상준 on 2022/08/28.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")!
        WebService().getArticles(url: url) { (articles) in
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("no matched articleTableViewCell identifier")}
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel?.text = articleVM.title
        cell.descriptionLabel?.text = articleVM.description
        
        return cell
    }
}
