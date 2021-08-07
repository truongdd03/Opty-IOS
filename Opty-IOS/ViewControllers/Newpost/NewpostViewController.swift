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
    
    static var selectedTags: [String]? = ["Javascript", "C", "C++"]
    static var username: String?
    
    var countries: [String] = []
    var countryPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if NewpostViewController.username == nil {
            Fetcher.fetchUsername()
        }
        
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
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        if !validateInputs() { return }
    
        var address = StreetInput.text! + ", " + CityInput.text! + ", " + StateInput.text! + ", "
        address += CountryInput.text!
    
        let post = Post(userName: NewpostViewController.username!, date: "", companyName: CompanyInput.text!, content: ContentInput.text, hasSent: false, tags: NewpostViewController.selectedTags!, address: address)
        post.updateDate()
        
        print(post)
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

