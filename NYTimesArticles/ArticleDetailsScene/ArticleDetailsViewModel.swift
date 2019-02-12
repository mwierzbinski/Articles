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
                               section: article.section,
                               imageUrl: URL(string: article.firsImageUrl))
    }
    
    init(article: Article) {
        self.article = article
    }
    
    func getImageData(onComplete: @escaping (Data?)->())
    {
        guard let imageUrl = detailsViewData.imageUrl else { return }
        
        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: imageUrl)
            DispatchQueue.main.async {
                onComplete(imageData)
            }
        }
    }
}

struct DetailsViewData {
    let title: String
    let abtract: String
    let section: String
    let imageUrl: URL?
}
