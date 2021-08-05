//
//  ExperienceTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var TagsCollection: UICollectionView!
    @IBOutlet weak var JobDescription: UITextView!
    @IBOutlet weak var DurationLabel: UILabel!
    
    var content = "" {
        didSet {
            JobDescription.text = content
        }
    }
    var duration = "" {
        didSet {
            DurationLabel.text = duration
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        TagsCollection.delegate = dataSourceDelegate
        TagsCollection.dataSource = dataSourceDelegate
        TagsCollection.tag = row
        TagsCollection.reloadData()
    }

}
