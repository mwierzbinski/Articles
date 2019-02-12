//
//  Article.swift
//  NYTimesArticles
//
//  Created by Michal W on 11/02/2019.
//  Copyright © 2019 Michal W. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let byline: String
    let abstract: String
    let section: String
    let publishedDate: Date
    
    private enum CodingKeys: String, CodingKey
    {
        case title
        case byline
        case abstract
        case section
        case publishedDate = "published_date"
    }
}
