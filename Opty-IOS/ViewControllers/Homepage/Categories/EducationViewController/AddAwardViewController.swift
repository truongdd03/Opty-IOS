//
//  AddAwardViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class AddAwardViewController: PopUpViewController {

    @IBOutlet weak var AwardNameInput: UITextField!
    @IBOutlet weak var DescriptionInput: UITextView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleHollowButton(CancelButton)
        Utilities.styleFilledButton(AddButton)
        DescriptionInput.layer.borderWidth = 1
        DescriptionInput.layer.borderColor = UIColor.systemBlue.cgColor
        DescriptionInput.layer.cornerRadius = 5
        AwardNameInput.layer.borderWidth = 1
        AwardNameInput.layer.borderColor = UIColor.systemBlue.cgColor
        AwardNameInput.layer.cornerRadius = 5
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateInputs() -> Bool {
        if (!AwardNameInput.hasText || !DescriptionInput.hasText) {
            showError(message: "Please fill all fields")
            return false
        }
        
        return true
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if (!validateInputs()) { return }
        
        EducationViewController.awards.append(Award(name: AwardNameInput.text!, content: DescriptionInput.text!))
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadAward"), object: nil)

        self.dismiss(animated: true, completion: nil)
    }
    
}
