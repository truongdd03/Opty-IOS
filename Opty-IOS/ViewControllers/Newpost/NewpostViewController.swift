//
//  NewpostViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class NewpostViewController: UIViewController {

    @IBOutlet weak var CompanyInput: UITextField!
    @IBOutlet weak var TagsCollection: UICollectionView!
    @IBOutlet weak var StreetInput: UITextField!
    @IBOutlet weak var CityInput: UITextField!
    @IBOutlet weak var StateInput: UITextField!
    @IBOutlet weak var CountryInput: UITextField!
    @IBOutlet weak var ContentInput: UITextView!
    @IBOutlet weak var PostButton: UIButton!
    
    static var selectedTags: [String]? = ["Javascript", "C", "C++"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New post"
        
        TagsCollection.delegate = self
        TagsCollection.dataSource = self
        
        setUp()
    }
    
    func setUp() {
        Utilities.styleSimpleTextField(textField: CompanyInput)
        Utilities.styleSimpleTextField(textField: StreetInput)
        Utilities.styleSimpleTextField(textField: CityInput)
        Utilities.styleSimpleTextField(textField: StateInput)
        Utilities.styleSimpleTextField(textField: CountryInput)
        Utilities.styleTextView(textView: ContentInput)
        Utilities.styleFilledButton(PostButton)
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func AddTagButtonTapped(_ sender: Any) {
    }
    
}

extension NewpostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewpostViewController.selectedTags!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: NewpostViewController.selectedTags![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(NewpostViewController.selectedTags![indexPath.item])
        
        return CGSize(width: width + 15, height: 20)
    }

}
