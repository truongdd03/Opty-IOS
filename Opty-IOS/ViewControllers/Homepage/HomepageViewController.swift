//
//  HomepageViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class HomepageViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let parts = ["Basics", "Education", "Experience", "Skills"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account"
        tableView.delegate = self
        tableView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.right.doc.on.clipboard"), style: .plain, target: self, action: #selector(logOut))
        
        fetchData()
    }

    func fetchData() {
        if BasicsViewController.basicInfo == nil {
            Fetcher.fetchInfo()
        }
        
        if EducationViewController.degrees == nil {
            Fetcher.fetchDegrees()
            Fetcher.fetchAwards()
        }
        
        if ExperienceViewController.jobs == nil {
            Fetcher.fetchJobs()
        }
        
        if SkillsViewController.skills == nil {
            Fetcher.fetchSkills()
            Fetcher.fetchTags()
        }
    }

    @objc func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.setValue(false, forKey: "isLoggedIn")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Lobby")
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomepageViewController: UITableViewDataSource, UITableViewDelegate {
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
