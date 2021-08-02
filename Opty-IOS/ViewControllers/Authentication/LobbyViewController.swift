//
//  ViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setToolbarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(LogInButton)
        Utilities.styleHollowButton(SignUpButton)
    }


}

