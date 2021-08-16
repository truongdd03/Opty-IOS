//
//  AddTagsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/2/21.
//

import UIKit

class AddTagsViewController: PopUpViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    @IBOutlet weak var BackButton: UIButton!
    
    var tags: [String] = []
    var filter: [String] = []
    var type = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleHollowButton(BackButton)
        
        TagsCollectionView.delegate = self
        TagsCollectionView.dataSource = self
        searchBar.delegate = self
        
        setUp()
    }
    
    func filterTags(selectedTags: [String]) {
        for tag in selectedTags {
            var id = 0
            while id < tags.count {
                if tags[id] == tag {
                    tags.remove(at: id)
                } else {
                    id += 1
                }
            }
        }
    }
    
    func setUp() {
        tags = fetchTags()
        if type == 0 {
            filterTags(selectedTags: SkillsViewController.tags!)
        } else {
            filterTags(selectedTags: NewpostViewController.tags)
        }
        filter = tags
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let tmp = tags
        filter = searchText.isEmpty ? tmp : tmp.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        TagsCollectionView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddTagsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: filter[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Utilities.sizeOfLabel(filter[indexPath.item]) + 15, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = filter[indexPath.item]
        filter.remove(at: indexPath.item)
        tags.remove(at: tags.firstIndex(of: tag)!)
        collectionView.reloadData()
        
        if type == 0 {
            SkillsViewController.tags!.insert(tag, at: 0)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadSkillTags"), object: nil)
        } else {
            NewpostViewController.tags.insert(tag, at: 0)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadPostTags"), object: nil)
        }
    }
    
}
