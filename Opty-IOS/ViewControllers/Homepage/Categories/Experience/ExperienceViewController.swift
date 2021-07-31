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
    
    static var jobs: [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Experience"
        
        ExperienceTableView.delegate = self
        ExperienceTableView.dataSource = self
        
        Utilities.styleHollowButton(BackButton)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Table view

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExperienceViewController.jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Job", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell as! ExperienceTableViewCell
        tableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

extension ExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExperienceViewController.jobs[collectionView.tag].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath)
        return cell
    }
}
