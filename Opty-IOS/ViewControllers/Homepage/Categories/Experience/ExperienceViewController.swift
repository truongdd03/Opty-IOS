//
//  ExperienceViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class ExperienceViewController: MyViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var ExperienceTableView: UITableView!
    @IBOutlet weak var AddButton: UIButton!
    
    static var jobs: [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Experience"
        
        ExperienceTableView.delegate = self
        ExperienceTableView.dataSource = self
        ExperienceTableView.allowsSelection = false
        
        Utilities.styleHollowButton(BackButton)
        Utilities.styleFilledButton(AddButton)
        
        fetchData()
    }
    
    func fetchData() {
        for _ in 0...3 {
            ExperienceViewController.jobs.append(Job(company: "Facebook", role: "Leader", tags: ["java", "swift", "c++", "html", "css"], content: "Hi how are you i'm fine", duration: "5 years"))
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Table view

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExperienceViewController.jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Job", for: indexPath) as! ExperienceTableViewCell
        cell.content = ExperienceViewController.jobs[indexPath.row].content
        cell.duration = ExperienceViewController.jobs[indexPath.row].duration
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell as! ExperienceTableViewCell
        tableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            ExperienceViewController.jobs.remove(at: indexPath.row)
            self.ExperienceTableView.deleteRows(at: [indexPath], with: .automatic)
            self.ExperienceTableView.reloadData()
        }
    }
}

// MARK: Collection view
extension ExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExperienceViewController.jobs[collectionView.tag].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
        
        cell.tagName.text = ExperienceViewController.jobs[collectionView.tag].tags[indexPath.item]
        cell.tagName.layer.borderWidth = 1
        cell.tagName.layer.cornerRadius = 5
        cell.tagName.layer.borderColor = UIColor.black.cgColor
        cell.tagName.layer.masksToBounds = true
        return cell
    }
}
