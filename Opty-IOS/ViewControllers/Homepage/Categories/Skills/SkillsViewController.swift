//
//  SkillsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/1/21.
//

import UIKit

class SkillsViewController: UIViewController {

    @IBOutlet weak var TagsCollectionView: UICollectionView!
    @IBOutlet weak var SkillsTableView: UITableView!
    
    static var skills: [Skill]?
    static var tags: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Skills"
        
        SkillsTableView.delegate = self
        SkillsTableView.dataSource = self
        SkillsTableView.allowsSelection = false
        
        TagsCollectionView.delegate = self
        TagsCollectionView.dataSource = self
        TagsCollectionView.layer.borderWidth = 1
        TagsCollectionView.layer.borderColor = UIColor.systemBlue.cgColor
        TagsCollectionView.layer.cornerRadius = 5
                
        NotificationCenter.default.addObserver(self, selector: #selector(loadSkillTags), name: NSNotification.Name(rawValue: "loadSkillTags"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadSkills), name: NSNotification.Name(rawValue: "loadSkills"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Writer.writeTags()
    }
    
    @objc func loadSkills() {
        SkillsTableView.reloadData()
    }
    
    @objc func loadSkillTags() {
        TagsCollectionView.reloadData()
    }
    
    func addTagTo(array: [String], tag: String) -> [String] {
        var arr = array
        if (arr.count == 0) {
            arr.append(tag)
            return arr
        }
        
        for i in 0..<arr.count-1 {
            if (tag > arr[i] && tag < arr[i+1]) {
                arr.insert(tag, at: i+1)
                return arr
            }
        }
        arr.insert(tag, at: 0)
        return arr
    }
    
}

extension SkillsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SkillsViewController.skills!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath) as! SkillTableViewCell
        
        cell.name = SkillsViewController.skills![indexPath.row].name
        cell.content = SkillsViewController.skills![indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Remover.removeSkill(skill: SkillsViewController.skills![indexPath.row])
            
            SkillsViewController.skills!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension SkillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SkillsViewController.tags!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: SkillsViewController.tags![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(SkillsViewController.tags![indexPath.item])
        return CGSize(width: width + 15, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = SkillsViewController.tags![indexPath.item]
        SkillsViewController.tags!.remove(at: indexPath.item)
        collectionView.reloadData()
        
        AddTagsViewController.tags = addTagTo(array: AddTagsViewController.tags!, tag: tag)
        AddTagsViewController.filter = addTagTo(array: AddTagsViewController.filter, tag: tag)
    }
}
