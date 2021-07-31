//
//  MyViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane.fill"), style: .plain, target: self, action: #selector(transitToHomeMessage))
    }
    
    @objc func transitToHomeMessage() {
        let storyBoard = UIStoryboard(name: "Message", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "HomeMessage") as! UITableViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
