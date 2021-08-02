//
//  MyCollectionViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class MyCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(transitToHomePage))
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane.fill"), style: .plain, target: self, action: #selector(transitToHomeMessage))
    }

    @objc func transitToHomePage() {
        let storyBoard = UIStoryboard(name: "Homepage", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Homepage") 
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func transitToHomeMessage() {
        let storyBoard = UIStoryboard(name: "Message", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "HomeMessage") as! UITableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
