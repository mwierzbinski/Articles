//
//  ViewController.swift
//  NYTimesArticles
//
//  Created by Michal W on 11/02/2019.
//  Copyright © 2019 Michal W. All rights reserved.
//

import UIKit

class ArticleListTableViewController: UITableViewController {

    private let viewModel: ArticleListViewModel
    private var data: [ArticleViewData]?

// Init
    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = ArticleListViewModel(networkingAPI: NetworkingAPI())
        super.init(coder: aDecoder)
    }

// Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        viewModel.ready()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == ArticleDetailsViewController.customSegueIdentifier ) {
            
            guard let detailsViewController = segue.destination as? ArticleDetailsViewController else {
                return
            }
            
            detailsViewController.update(with: viewModel.selectedArticle)
        }
    }
}

//UITableViewDataSource
extension ArticleListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = data else { return ArticleListTableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListTableViewIdentifier", for: indexPath) as! ArticleListTableViewCell
        
        let articleViewModel = data[indexPath.row]
        cell.title.text = articleViewModel.title
        cell.writtenBy.text = articleViewModel.writtenBy
        cell.date.text = articleViewModel.date
        // TODO: Image
        
        return cell
    }
}

//UITableViewDelegate
extension ArticleListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        performSegue(withIdentifier: ArticleDetailsViewController.customSegueIdentifier, sender: self)
    }
}

extension ArticleListTableViewController : ArticleListViewModelDelegate {
    func articleListViewModel(_ articleViewModel: ArticleListViewModel, didReceiveArticles articles: [ArticleViewData]) {
        data = articles
        tableView.reloadData()
    }
}


