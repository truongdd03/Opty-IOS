//
//  EducationViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class EducationViewController: MyViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var DegreeTableView: UITableView!
    @IBOutlet weak var AwardTableView: UITableView!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Education"
        
        DegreeTableView.layer.borderWidth = 1
        DegreeTableView.layer.borderColor = UIColor.systemBlue.cgColor
        AwardTableView.layer.borderWidth = 1
        AwardTableView.layer.borderColor = UIColor.systemBlue.cgColor
        Utilities.styleFilledButton(SaveButton)
        Utilities.styleHollowButton(CancelButton)
        
        DegreeTableView.delegate = self
        DegreeTableView.dataSource = self
        AwardTableView.delegate = self
        AwardTableView.dataSource = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == DegreeTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DegreeCell") as! DegreeTableViewCell
            cell.schoolName = "University of California - San Diego"
            cell.degreeName = "BS in Computer Science"
            cell.startDate = "Jun 21"
            cell.endDate = "Sep 25"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AwardCell")!
            cell.textLabel?.text = "Your scholarship"
            cell.detailTextLabel?.text = "This is a scholarship for only you! You are the best!"
            return cell
        }

    }

}
