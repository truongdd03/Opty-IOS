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
    var buttonTitle: String?
    var buttonClicked: Bool? {
        didSet {
            if buttonClicked == true {
                if buttonTitle == "Reject" {
                    Button.setTitle("Rejected", for: .normal)
                } else {
                    Button.setTitle("Sent", for: .normal)
                }
                Utilities.styleHollowMiniButton(Button)
            } else {
                Button.setTitle(buttonTitle, for: .normal)
                if buttonTitle == "Reject" {
                    Utilities.styleFilledMiniButton(Button, color: UIColor.systemRed)
                } else {
                    Utilities.styleFilledMiniButton(Button, color: UIColor.systemGreen)
                }
            }
        }
    }
    var address: String? {
        didSet {
            AddressLabel.text = address
        }
    }
    var postID: String?

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        TagsCollection.delegate = dataSourceDelegate
        TagsCollection.dataSource = dataSourceDelegate
        TagsCollection.tag = row
        TagsCollection.reloadData()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if buttonClicked == false {
            if buttonTitle == "Reject" {
                Remover.removeApplicant(postID: postID!, uid: id!)
            } else {
                Writer.writeApplicants(postID: id!)
            }
        }
        buttonClicked = true
    }
    
    @IBAction func MessageButtonTapped(_ sender: Any) {
    }
}
