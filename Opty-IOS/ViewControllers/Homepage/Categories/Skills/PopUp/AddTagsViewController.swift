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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleHollowButton(BackButton)
        
        TagsCollectionView.delegate = self
        TagsCollectionView.dataSource = self
        searchBar.delegate = self
        
        tags = fetchTags()
        filter = tags
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = searchText.isEmpty ? tags : tags.filter { (item: String) -> Bool in
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
    
}
