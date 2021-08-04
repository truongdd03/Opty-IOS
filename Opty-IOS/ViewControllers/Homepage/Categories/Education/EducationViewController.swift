//
//  EducationViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit
import Firebase

class EducationViewController: UIViewController {
    
    @IBOutlet weak var DegreeTableView: UITableView!
    @IBOutlet weak var AwardTableView: UITableView!
    
    static var degrees: [Degree]?
    static var awards: [Award]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Education"
        
        setUp()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadDegree), name: NSNotification.Name(rawValue: "loadDegree"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadAward), name: NSNotification.Name(rawValue: "loadAward"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setUp() {
        DegreeTableView.layer.borderWidth = 1
        DegreeTableView.layer.borderColor = UIColor.systemBlue.cgColor
        AwardTableView.layer.borderWidth = 1
        AwardTableView.layer.borderColor = UIColor.systemBlue.cgColor
        
        DegreeTableView.delegate = self
        DegreeTableView.dataSource = self
        AwardTableView.delegate = self
        AwardTableView.dataSource = self
        
        DegreeTableView.allowsSelection = false
        AwardTableView.allowsSelection = false
    }
    
    @objc func loadDegree() {
        self.DegreeTableView.reloadData()
    }
    
    @objc func loadAward() {
        self.AwardTableView.reloadData()
    }

}

extension EducationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == DegreeTableView) {
            return EducationViewController.degrees!.count
        }
        return EducationViewController.awards!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == DegreeTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DegreeCell") as! DegreeTableViewCell
            let tmp: Degree = EducationViewController.degrees![indexPath.row]
            cell.schoolName = tmp.school
            cell.degreeName = tmp.degree
            cell.startDate = tmp.startDate
            cell.endDate = tmp.endDate
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AwardCell")!
        cell.textLabel?.text = EducationViewController.awards![indexPath.row].name
        cell.detailTextLabel?.text = EducationViewController.awards![indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
        
            if (tableView == DegreeTableView) {
                EducationViewController.degrees?.remove(at: indexPath.row)
                self.DegreeTableView.deleteRows(at: [indexPath], with: .automatic)
                self.DegreeTableView.reloadData()
            } else {
                EducationViewController.awards!.remove(at: indexPath.row)
                self.AwardTableView.deleteRows(at: [indexPath], with: .automatic)
                self.AwardTableView.reloadData()
            }
            
        }
    }
}
