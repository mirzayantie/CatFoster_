//
//  CatCollectionViewCell.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 17/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var catTitleLabel: UILabel!
    
    var catProfile: CatProfile! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let catProfile = catProfile {
            featuredImageView.image = catProfile.catImage
            catTitleLabel.text = catProfile.catName
            //backgroundColorView.backgroundColor = catProfile.color
        } else {
            featuredImageView.image = nil
            catTitleLabel.text = nil
            //backgroundColorView.backgroundColor = nil
        }
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        featuredImageView.layer.cornerRadius = 10.0
        featuredImageView.layer.masksToBounds = true
    }
    
    
    
}
