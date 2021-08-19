//
//  NewpostViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class NewpostViewController: PopUpViewController, UITextFieldDelegate {

    @IBOutlet weak var CompanyInput: UITextField!
    @IBOutlet weak var TagsCollection: UICollectionView!
    @IBOutlet weak var StreetInput: UITextField!
    @IBOutlet weak var CityInput: UITextField!
    @IBOutlet weak var StateInput: UITextField!
    @IBOutlet weak var CountryInput: UITextField!
    @IBOutlet weak var ContentInput: UITextView!
    @IBOutlet weak var PostButton: UIButton!
    
    static var tags: [String] = []
    
    var countries: [String] = []
    var countryPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .plain, target: self, action: #selector(showPosts))
        
        TagsCollection.delegate = self
        TagsCollection.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadPostTags), name: NSNotification.Name(rawValue: "loadPostTags"), object: nil)
        
        setUp()
    }
    
    @objc func showPosts() {
        let storyBoard = UIStoryboard(name: "Newpost", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Posts")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loadPostTags() {
        TagsCollection.reloadData()
    }
    
    func setUp() {
        Utilities.styleSimpleTextField(textField: CompanyInput)
        Utilities.styleSimpleTextField(textField: StreetInput)
        Utilities.styleSimpleTextField(textField: CityInput)
        Utilities.styleSimpleTextField(textField: StateInput)
        Utilities.styleSimpleTextField(textField: CountryInput)
        Utilities.styleTextView(textView: ContentInput)
        Utilities.styleFilledButton(PostButton)
        
        countries = Utilities.fetchCountries()
        
        CountryInput.inputView = countryPickerView
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        CountryInput.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func validateInputs() -> Bool {
        if (!CompanyInput.hasText || !StreetInput.hasText || !CityInput.hasText || !StateInput.hasText || !CountryInput.hasText || !ContentInput.hasText) {
            showError(message: "Please fill all fields!")
            return false
        }
        
        return true
    }
    
    func resetInputs() {
        CompanyInput.text = ""
        StreetInput.text = ""
        CityInput.text = ""
        StateInput.text = ""
        CountryInput.text = ""
        ContentInput.text = ""
        
        NewpostViewController.tags.removeAll()
        TagsCollection.reloadData()
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        if !validateInputs() { return }
    
        var address = StreetInput.text! + ", " + CityInput.text! + ", " + StateInput.text! + ", "
        address += CountryInput.text!
    
        let post = Post(userName: HomepageViewController.username!, date: "", title: CompanyInput.text!, content: ContentInput.text, tags: NewpostViewController.tags, address: address, applicantsNumber: 0)
        post.updateDate()
        post.id = Writer.writePost(post: post)

        Index.updatePost(tags: post.tags, content: post.content, postID: post.id!, isDelete: false)
        
        resetInputs()
        alert(title: "Successfully posted!", message: "")
    }
    
    @IBAction func addTagsButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Homepage", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "AddTags") as! AddTagsViewController
        vc.modalPresentationStyle = .popover
        vc.type = 1
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension NewpostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = countries[row]
        label.sizeToFit()
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CountryInput.text = countries[row]
    }
}

extension NewpostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewpostViewController.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        cell.setLabel(tag: NewpostViewController.tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(NewpostViewController.tags[indexPath.item])
        return CGSize(width: width + 15, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NewpostViewController.tags.remove(at: indexPath.item)
        collectionView.reloadData()
    }
}
