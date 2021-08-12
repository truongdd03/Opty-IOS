//
//  PostTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/11/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var ApplicantsNumberLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CompanyLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!

    var applicantsNumber: Int? {
        didSet {
            ApplicantsNumberLabel.text = String(applicantsNumber!)
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
    
    var address: String? {
        didSet {
            AddressLabel.text = address
        }
    }
    
    var content: String? {
        didSet {
            ContentLabel.text = content
        }
    }

}
