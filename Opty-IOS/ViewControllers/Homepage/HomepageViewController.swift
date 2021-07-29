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
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        //let customCell = UINib(nibName: "DetailsCell", bundle: nil)
        //tableView.register(customCell, forCellReuseIdentifier: "DetailsCell")

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsTableViewCell
        cell.cellLabel = "This is row \(indexPath.row)"

        return cell
    }
}
