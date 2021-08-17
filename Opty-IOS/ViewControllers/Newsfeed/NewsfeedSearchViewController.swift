//
//  NewsfeedSearchViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/16/21.
//

import UIKit

class NewsfeedSearchViewController: UIViewController {

    @IBOutlet weak var KeywordsSearchBar: UISearchBar!
    @IBOutlet weak var TagsCollection: UICollectionView!
    @IBOutlet weak var SearchButton: UIButton!
    
    static var tags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Opty"
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadSearchPostTags), name: NSNotification.Name(rawValue: "loadSearchPostTags"), object: nil)
        
        setUp()
    }

    @objc func loadSearchPostTags() {
        TagsCollection.reloadData()
    }

    func setUp() {
        Utilities.styleHollowButton(SearchButton)
        
        TagsCollection.delegate = self
        TagsCollection.dataSource = self
        TagsCollection.layer.borderWidth = 1
        TagsCollection.layer.borderColor = UIColor.systemBlue.cgColor
        TagsCollection.layer.cornerRadius = 5
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addTagsButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Homepage", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "AddTags") as! AddTagsViewController
        vc.modalPresentationStyle = .popover
        vc.type = 2
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension NewsfeedSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsfeedSearchViewController.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: NewsfeedSearchViewController.tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(NewsfeedSearchViewController.tags[indexPath.item])
        return CGSize(width: width + 15, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NewsfeedSearchViewController.tags.remove(at: indexPath.item)
        collectionView.reloadData()
    }
}
