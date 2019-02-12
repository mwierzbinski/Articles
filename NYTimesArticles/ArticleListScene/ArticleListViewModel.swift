//
//  ArticleListViewModel.swift
//  NYTimesArticles
//
//  Created by Michal W on 12/02/2019.
//  Copyright © 2019 Michal W. All rights reserved.
//

import Foundation


protocol ArticleListViewModelDelegate: class {
    func articleListViewModel(_ articleViewModel: ArticleListViewModel, didReceiveArticles articles: [ArticleViewData])
    // TODO: Add fail to receive Articles
}

final class ArticleListViewModel {
    
    weak var delegate: ArticleListViewModelDelegate?
    private let networkingApi: NetworkingService
    private var articles: [Article]?
    private var articleIndex: Int?
    var selectedArticle: Article {
        
        return articles![articleIndex!]
    }
    
    init(networkingAPI: NetworkingService) {
        self.networkingApi = networkingAPI
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        articleIndex = indexPath.row
    }
    
    func ready() {
        networkingApi.mostViewedArticles { [weak self] articles in
            
            guard let strongSelf = self else { return }
            
            strongSelf.articles = articles
            let articleViewModels = articles.map { ArticleViewData(article: $0) }
            strongSelf.delegate?.articleListViewModel(strongSelf, didReceiveArticles: articleViewModels)
        }
    }
}

struct ArticleViewData {
    let title: String
    let writtenBy: String
    let date: String
    let imageUrl: URL?
}

extension ArticleViewData {
    init(article: Article) {
        self.title = article.title
        self.writtenBy = article.byline
        self.imageUrl = URL(string: article.firsImageUrl)
        
        let formatter = DateFormatter.articleDate
        self.date = formatter.string(from: article.publishedDate)
    }
}

extension DateFormatter {
    static let articleDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        return formatter
    }()
}
