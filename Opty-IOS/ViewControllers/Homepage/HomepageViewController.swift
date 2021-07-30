//
//  HomepageViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit

class HomepageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let parts = ["Basics", "Education", "Experience", "Skills"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsTableViewCell
        cell.cellLabel = parts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Homepage", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: parts[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}
