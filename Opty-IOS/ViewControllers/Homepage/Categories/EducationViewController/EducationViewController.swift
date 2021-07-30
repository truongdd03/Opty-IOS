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
    
    var degrees: [Degree] = []
    var awards: [Award] = []
    
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
        
        DegreeTableView.allowsSelection = false
        
        fetchData()
    }
    
    func fetchData() {
        for _ in 0...5 {
            degrees.append(Degree(school: "Michigan State University", degree: "BS in Computer Science", startDate: "Sep 21", endDate: "Jun 25"))
            awards.append(Award(name: "You are welcome here", content: "Hi! This is your scholarship"))
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == DegreeTableView) {
            return degrees.count
        }
        return awards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == DegreeTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DegreeCell") as! DegreeTableViewCell
            let tmp: Degree = degrees[indexPath.row]
            cell.schoolName = tmp.school
            cell.degreeName = tmp.degree
            cell.startDate = tmp.startDate
            cell.endDate = tmp.endDate
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AwardCell")!
        cell.textLabel?.text = awards[indexPath.row].name
        cell.detailTextLabel?.text = awards[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
        
            if (tableView == DegreeTableView) {
                self.degrees.remove(at: indexPath.row)
                self.DegreeTableView.deleteRows(at: [indexPath], with: .automatic)
                self.DegreeTableView.reloadData()
            } else {
                self.awards.remove(at: indexPath.row)
                self.AwardTableView.deleteRows(at: [indexPath], with: .automatic)
                self.AwardTableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
