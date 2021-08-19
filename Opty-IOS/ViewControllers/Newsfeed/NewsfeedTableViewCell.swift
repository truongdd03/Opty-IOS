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
    @IBOutlet weak var SendResumeButton: UIButton!
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
            CompanyLabel.text = title
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
                SendResumeButton.setTitle("Sent", for: .normal)
                Utilities.styleHollowMiniButton(SendResumeButton)
            } else {
                SendResumeButton.setTitle("Send Resume", for: .normal)
                Utilities.styleFilledMiniButton(SendResumeButton, color: UIColor.systemGreen)
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
    
    @IBAction func sendResumeButtonTapped(_ sender: Any) {
        buttonClicked = true
        Writer.writeApplicants(postID: id!)
    }
    
    @IBAction func MessageButtonTapped(_ sender: Any) {
    }
}
