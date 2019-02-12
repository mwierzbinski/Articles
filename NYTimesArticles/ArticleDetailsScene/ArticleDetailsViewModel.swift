//
//  ArticleDetailsViewModel.swift
//  NYTimesArticles
//
//  Created by Michal W on 12/02/2019.
//  Copyright © 2019 Michal W. All rights reserved.
//

import Foundation

final class ArticleDetailsViewModel {
    private let article: Article
    
    var detailsViewData: DetailsViewData {
        return DetailsViewData(title: article.title,
                               abtract: article.abstract,
                               section: article.section)
    }
    
    init(article: Article) {
        self.article = article
    }
    
    
}

struct DetailsViewData {
    let title: String
    let abtract: String
    let section: String
    //TODO: add image
}
