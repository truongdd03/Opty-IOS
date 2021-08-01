//
//  TagCollectionViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagName: UILabel!
    
    public func setLabel(tag: String) {
        tagName.text = tag
        tagName.layer.borderWidth = 1
        tagName.layer.cornerRadius = 5
        tagName.layer.borderColor = UIColor.black.cgColor
        tagName.layer.masksToBounds = true
    }
}
