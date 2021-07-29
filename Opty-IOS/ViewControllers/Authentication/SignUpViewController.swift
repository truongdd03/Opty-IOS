//
//  SignUpViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameInput: UITextField!
    @IBOutlet weak var LastNameInput: UITextField!
    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var PasswordInput: UITextField!
    @IBOutlet weak var PasswordInput1: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = "Sign Up"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleTextField(FirstNameInput)
        Utilities.styleTextField(LastNameInput)
        Utilities.styleTextField(EmailInput)
        Utilities.styleTextField(PasswordInput)
        Utilities.styleTextField(PasswordInput1)
        Utilities.styleFilledButton(SignUpButton)
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
