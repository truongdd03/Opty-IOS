//
//  AddSkillViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/2/21.
//

import UIKit

class AddSkillViewController: PopUpViewController {

    @IBOutlet weak var SkillNameInput: UITextField!
    @IBOutlet weak var SkillContentTextView: UITextView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleSimpleTextField(textField: SkillNameInput)
        Utilities.styleTextView(textView: SkillContentTextView)
        Utilities.styleFilledButton(AddButton)
        Utilities.styleHollowButton(CancelButton)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateInputs() -> Bool {
        if (!SkillNameInput.hasText || !SkillContentTextView.hasText) {
            showError(message: "Please fill all fields")
            return false
        }
        
        return true
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if (!validateInputs()) { return }
        
        let tmp = Skill(name: SkillNameInput.text!, content: SkillContentTextView.text!)
        
        SkillsViewController.skills!.append(tmp)
        Writer.writeSkill(skill: tmp)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadSkills"), object: nil)

        self.dismiss(animated: true, completion: nil)
    }

}
