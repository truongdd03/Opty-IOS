//
//  AddExperienceViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/1/21.
//

import UIKit

class AddExperienceViewController: PopUpViewController {

    @IBOutlet weak var CompanyInput: UITextField!
    @IBOutlet weak var RoleInput: UITextField!
    @IBOutlet weak var DuarationInput: UITextField!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var JobDescriptionInput: UITextView!
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleSimpleTextField(textField: CompanyInput)
        Utilities.styleSimpleTextField(textField: RoleInput)
        Utilities.styleSimpleTextField(textField: DuarationInput)
        Utilities.styleFilledButton(AddButton)
        Utilities.styleHollowButton(CancelButton)
        Utilities.styleTextView(textView: JobDescriptionInput)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
