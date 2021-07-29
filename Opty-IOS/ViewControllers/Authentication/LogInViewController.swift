//
//  LogInViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = "Log In"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(LogInButton)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
    }
    
    func showError(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func validateInputs() -> Bool {
        if (!EmailTextField.hasText || !PasswordTextField.hasText) {
            showError(message: "Invalid email/password")
            return false;
        }
        return true;
    }
    
    @IBAction func LogInButtonTapped(_ sender: Any) {
        if (!validateInputs()) { return }
        
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.showError(message: error.localizedDescription)
                return
            }
            
            self.transitToNewsfeed()
        }
    }
    
    func transitToNewsfeed() {
        let storyBoard = UIStoryboard(name: "Newsfeed", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Newsfeed") as! MyCollectionViewController
        navigationController?.pushViewController(vc, animated: true)
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
