//
//  AddExperienceViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/1/21.
//

import UIKit

class AddExperienceViewController: PopUpViewController, UISearchBarDelegate {
    @IBOutlet weak var CompanyInput: UITextField!
    @IBOutlet weak var RoleInput: UITextField!
    @IBOutlet weak var DuarationInput: UITextField!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var JobDescriptionInput: UITextView!
    
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    @IBOutlet weak var DeselectedTagsCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedTags: [String] = []
    var tags: [String] = []
    var deselectedTags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleSimpleTextField(textField: CompanyInput)
        Utilities.styleSimpleTextField(textField: RoleInput)
        Utilities.styleSimpleTextField(textField: DuarationInput)
        Utilities.styleFilledButton(AddButton)
        Utilities.styleHollowButton(CancelButton)
        Utilities.styleTextView(textView: JobDescriptionInput)
        
        TagsCollectionView.delegate = self
        TagsCollectionView.dataSource = self
        DeselectedTagsCollectionView.delegate = self
        DeselectedTagsCollectionView.dataSource = self
        searchBar.delegate = self
        
        tags = fetchTags()
        deselectedTags = tags
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        deselectedTags = searchText.isEmpty ? tags : tags.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        DeselectedTagsCollectionView.reloadData()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateInputs() -> Bool {
        if (!CompanyInput.hasText || !RoleInput.hasText || !DuarationInput.hasText || !JobDescriptionInput.hasText) {
            showError(message: "Please fill all fields")
            return false;
        }
        return true;
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if (!validateInputs()) { return }
        
        let tmp = Job(company: CompanyInput.text!, role: RoleInput.text!, tags: selectedTags, content: JobDescriptionInput.text!, duration: DuarationInput.text!)
        ExperienceViewController.jobs.append(tmp)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadExperience"), object: nil)

        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == TagsCollectionView) {
            return selectedTags.count
        }
        return deselectedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == TagsCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
            cell.setLabel(tag: selectedTags[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeselectedTag", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: deselectedTags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == TagsCollectionView) {
            let tag = selectedTags[indexPath.item]
            selectedTags.remove(at: indexPath.item)
            TagsCollectionView.deleteItems(at: [indexPath])
                        
            deselectedTags = addTagTo(array: deselectedTags, tag: tag)
            tags = addTagTo(array: tags, tag: tag)
            DeselectedTagsCollectionView.reloadData()
        } else {
            let tag = deselectedTags[indexPath.item]
            deselectedTags.remove(at: indexPath.item)
            DeselectedTagsCollectionView.deleteItems(at: [indexPath])
            
            let id = tags.firstIndex(of: tag)!
            tags.remove(at: id)
            
            selectedTags.insert(tag, at: 0)
            TagsCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == TagsCollectionView) {
            return CGSize(width: Utilities.sizeOfLabel(selectedTags[indexPath.item]) + 15, height: 20)
        } else {
            let label = UILabel()
            label.text = deselectedTags[indexPath.item]
            
            return CGSize(width: Utilities.sizeOfLabel(deselectedTags[indexPath.item]) + 20, height: 25)
        }
        
    }

}
