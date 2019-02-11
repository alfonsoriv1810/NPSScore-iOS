//
//  KNpsValueCollectionViewCell.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/10/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KNpsValueCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var npsValueImageView: UIImageView!
    @IBOutlet weak var npsValueLabel: UILabel!
    
    func updateCellWithIndex(index:Int) {
        self.npsValueLabel.text = "\(index)"
        self.npsValueImageView.image = UIImage.init(imageLiteralResourceName: "baby_\(index)")
    }
    
    func setCurrentCellAsSelected(selected:Bool) {
        self.npsValueImageView.layer.borderColor = UIColor.white.cgColor
        if selected {
            self.npsValueImageView.layer.borderWidth = 5
        } else {
            self.npsValueImageView.layer.borderWidth = 0
        }
    }
}
