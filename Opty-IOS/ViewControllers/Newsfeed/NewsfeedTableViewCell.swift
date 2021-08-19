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
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var TagsCollection: UICollectionView!
    
    var id: String?
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
    var title: String? {
        didSet {
            TitleLabel.text = title
        }
    }
    var content: String? {
        didSet {
            ContentLabel.text = content
        }
    }
    var buttonClicked: Bool? {
        didSet {
            if buttonClicked == true {
                Button.setTitle("Sent", for: .normal)
                Utilities.styleHollowMiniButton(Button)
            } else {
                Button.setTitle("Send Resume", for: .normal)
                Utilities.styleFilledMiniButton(Button, color: UIColor.systemGreen)
            }
        }
    }
    var address: String? {
        didSet {
            AddressLabel.text = address
        }
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        TagsCollection.delegate = dataSourceDelegate
        TagsCollection.dataSource = dataSourceDelegate
        TagsCollection.tag = row
        TagsCollection.reloadData()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if buttonClicked == false {
            Writer.writeApplicants(postID: id!)
        }
        buttonClicked = true
    }
    
    @IBAction func MessageButtonTapped(_ sender: Any) {
    }
}
