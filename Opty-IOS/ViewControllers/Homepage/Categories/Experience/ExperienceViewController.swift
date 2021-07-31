//
//  ExperienceViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class ExperienceViewController: MyViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var ExperienceTableView: UITableView!
    
    static var jobs: [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Experience"
        
        ExperienceTableView.delegate = self
        ExperienceTableView.dataSource = self
        
        Utilities.styleHollowButton(BackButton)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Table view

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExperienceViewController.jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
