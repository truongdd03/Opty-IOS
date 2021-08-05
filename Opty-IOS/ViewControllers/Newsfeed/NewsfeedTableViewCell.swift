//
//  NewsfeedTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {

    @IBOutlet weak var AvatarView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CompanyLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!

    @IBOutlet weak var TagsCollection: UICollectionView!
    
    var name: String? {
        didSet {
            NameLabel.text = name
        }
    }
    var date: String? {
        didSet {
            DateLabel.text = date
        }
    }
    var company: String? {
        didSet {
            CompanyLabel.text = company
        }
    }
    var content: String? {
        didSet {
            ContentLabel.text = content
        }
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        TagsCollection.delegate = dataSourceDelegate
        TagsCollection.dataSource = dataSourceDelegate
        TagsCollection.tag = row
        TagsCollection.reloadData()
    }

    @IBAction func MessageButtonTapped(_ sender: Any) {
    }
}
