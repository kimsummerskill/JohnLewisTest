//
//  ProductGridProductCell.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ProductGridProductCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var productImageView: DownloadableImageView!
    
    func update(with model: ProductModel) {
    
        // Cancel the download if it has not downloaded as the user may be swiping down a load of cells and we
        // probably donw want to bottleneck the user with images that they dont want to look at.
        // If the image has already downloaded, it will be cached so we wont download it a second time.
        productImageView.cancelExistingDownload()
        
        // Clear out the image on this cell so we dont leave an old image there while we are downloading a new image
        // on a reused cell. Can also drop a placeholder in here if you wish.
        productImageView.image = nil
        
        if let imageURL = model.imageURL {
            productImageView.loadImage(with: imageURL)
        }
        
        nameLabel.text = model.title
        priceLabel.text = model.price.priceString
    }
}
