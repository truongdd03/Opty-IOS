//
//  ExperienceTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var TagsCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        TagsCollection.delegate = dataSourceDelegate
        TagsCollection.dataSource = dataSourceDelegate
        TagsCollection.tag = row
        TagsCollection.reloadData()
    }

}
