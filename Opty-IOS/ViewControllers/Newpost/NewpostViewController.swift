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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New post"
        
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
