//
//  ExperienceViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class ExperienceViewController: MyViewController {

    @IBOutlet weak var ExperienceTableView: UITableView!
    
    static var jobs: [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Experience"
        
        ExperienceTableView.delegate = self
        ExperienceTableView.dataSource = self
        ExperienceTableView.allowsSelection = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadExperience), name: NSNotification.Name(rawValue: "loadExperience"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addExperience))
        
    }
    
    @objc func addExperience() {
        let storyBoard = UIStoryboard(name: "Homepage", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "AddExperience")
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func loadExperience() {
        ExperienceTableView.reloadData()
    }
    
}

extension ExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExperienceViewController.jobs[collectionView.tag].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
        
        cell.setLabel(tag: ExperienceViewController.jobs[collectionView.tag].tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(ExperienceViewController.jobs[collectionView.tag].tags[indexPath.item])
        
        return CGSize(width: width + 15, height: 20)
    }
}

extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource {
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
