//
//  SkillsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/1/21.
//

import UIKit

class SkillsViewController: MyViewController {

    @IBOutlet weak var TagsCollectionView: UICollectionView!
    @IBOutlet weak var SkillsTableView: UITableView!
    @IBOutlet weak var BackButton: UIButton!
    
    static var skills: [Skill] = []
    static var tags: [String] = ["Javascript", "C", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Skills"
        Utilities.styleHollowButton(BackButton)
        
        SkillsTableView.delegate = self
        SkillsTableView.dataSource = self
        SkillsTableView.allowsSelection = false
        
        TagsCollectionView.delegate = self
        TagsCollectionView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        for _ in 0...3 {
            SkillsViewController.skills.append(Skill(name: "Team working", content: "kjfdslkjf fkdsjfldjs"))
        }
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SkillsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SkillsViewController.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath) as! SkillTableViewCell
        
        cell.name = SkillsViewController.skills[indexPath.row].name
        cell.content = SkillsViewController.skills[indexPath.row].content
        
        return cell
    }
}

extension SkillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SkillsViewController.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: SkillsViewController.tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(SkillsViewController.tags[indexPath.item])
        return CGSize(width: width + 15, height: 20)
    }
}
