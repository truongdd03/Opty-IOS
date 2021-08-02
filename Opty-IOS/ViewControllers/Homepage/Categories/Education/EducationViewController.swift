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
    
    static var degrees: [Degree] = []
    static var awards: [Award] = []
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Education"
        
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
        
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadDegree), name: NSNotification.Name(rawValue: "loadDegree"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadAward), name: NSNotification.Name(rawValue: "loadAward"), object: nil)

    }
    
    @objc func loadDegree() {
        self.DegreeTableView.reloadData()
    }
    
    @objc func loadAward() {
        self.AwardTableView.reloadData()
    }
    
    func fetchData() {
        /*for _ in 0...5 {
            EducationViewController.degrees.append(Degree(school: "Michigan State University", degree: "BS in Computer Science", startDate: "Sep 21", endDate: "Jun 25"))
            EducationViewController.awards.append(Award(name: "You are welcome here", content: "Hi! This is your scholarship"))
        }*/
    }
    
    @IBAction func addDegreeButtonTapped(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)

    }
    // MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == DegreeTableView) {
            return EducationViewController.degrees.count
        }
        return EducationViewController.awards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == DegreeTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DegreeCell") as! DegreeTableViewCell
            let tmp: Degree = EducationViewController.degrees[indexPath.row]
            cell.schoolName = tmp.school
            cell.degreeName = tmp.degree
            cell.startDate = tmp.startDate
            cell.endDate = tmp.endDate
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AwardCell")!
        cell.textLabel?.text = EducationViewController.awards[indexPath.row].name
        cell.detailTextLabel?.text = EducationViewController.awards[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
        
            if (tableView == DegreeTableView) {
                EducationViewController.degrees.remove(at: indexPath.row)
                self.DegreeTableView.deleteRows(at: [indexPath], with: .automatic)
                self.DegreeTableView.reloadData()
            } else {
                EducationViewController.awards.remove(at: indexPath.row)
                self.AwardTableView.deleteRows(at: [indexPath], with: .automatic)
                self.AwardTableView.reloadData()
            }
            
        }
    }

}
