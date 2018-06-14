//
//  ShimmeringView.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Shimmer

class ShimmeringView: FBShimmeringView {
    
    @IBOutlet var shimmerContentView: UIView!;
    
    override func awakeFromNib() {

        super.awakeFromNib()
        self.setup()
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

    func setup() {

        self.contentView = self.shimmerContentView;
        // Start shimmering.
        self.isShimmering = true;
        self.clipsToBounds = true;
        self.shimmerContentView.clipsToBounds = true
    }
}
