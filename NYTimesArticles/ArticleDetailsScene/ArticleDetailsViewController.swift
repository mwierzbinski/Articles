//
//  ArticleDetailsViewController.swift
//  NYTimesArticles
//
//  Created by Michal W on 12/02/2019.
//  Copyright © 2019 Michal W. All rights reserved.
//

import Foundation
import UIKit

protocol CustomSegueIdentifiable {
    static var customSegueIdentifier: String { get }
}

extension UIViewController: CustomSegueIdentifiable {
    static var customSegueIdentifier: String {
        return String(describing: self)
    }
}

final class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var abstractInfo: UILabel!
    @IBOutlet weak var section: UILabel!
    
    private var viewModel: ArticleDetailsViewModel?
    private var data: DetailsViewData?
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let data = data else { return }
        articleTitle.text = data.title
        abstractInfo.text = data.abtract
        section.text = data.section
    }
    
    func update(with article: Article) {
        viewModel = ArticleDetailsViewModel(article: article)
        data = viewModel?.detailsViewData
    }
}
