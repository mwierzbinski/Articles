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
    let media: [Media]
    let publishedDate: Date
    var firsImageUrl: String {
        guard let metaData = self.media.first?.metadata?.first else { return "" }

        return metaData.url
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case title
        case byline
        case abstract
        case section
        case media
        case publishedDate = "published_date"
    }
}

struct Media: Codable {
    let metadata: [MediaMetadata]?
    
    private enum CodingKeys: String, CodingKey {
        case metadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
}
