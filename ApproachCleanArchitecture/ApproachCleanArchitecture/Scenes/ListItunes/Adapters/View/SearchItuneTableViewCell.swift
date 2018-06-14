//
//  SearchItunesTableViewCell.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit
import SDWebImage

class SearchItuneMusicTableViewCell: UITableViewCell {
    
    @IBOutlet var ordinalLabel: UILabel!
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
}

extension SearchItuneMusicTableViewCell: CellBindable {
    
    typealias T = SearchResultViewModel
    
    func bind(viewModel: SearchResultViewModel) {
        
        self.ordinalLabel.text = "\(viewModel.orderNumber)"
        self.artworkImageView.image = UIImage.init(named: "ic_band")
        
        self.artworkImageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: nil, options: SDWebImageOptions.refreshCached, completed: nil)
        
        self.trackNameLabel.text = viewModel.trackName
//        self.artistNameLabel.text = viewModel.artistName
//        self.albumNameLabel.text = viewModel.collectionName
//        self.timeLabel.text = viewModel.trackTime
//        self.priceLabel.text = viewModel.trackPriceFormat
    }
}
