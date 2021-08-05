//
//  NewsfeedViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class NewsfeedViewController: UIViewController {

    @IBOutlet weak var NewsfeedTableView: UITableView!
    
    static var posts: [Post]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle.fill"), style: .plain, target: self, action: #selector(searchTapped))
                
        title = "Opty"
        
        NewsfeedTableView.delegate = self
        NewsfeedTableView.dataSource = self
        NewsfeedTableView.allowsSelection = false
        
        for _ in 0...3 {
            NewsfeedViewController.posts?.append(Post(userName: "Don Truong", date: "23/10/21", companyName: "Facebook", content: "We need a software developer", tags: ["iOS", "Swift", "Front-end"]))
        }
        
        NewsfeedViewController.posts?.append(Post(userName: "Don Truong", date: "23/10/21", companyName: "Facebook", content: "We need a software developer has at least 1 month experience. Know how to use computer, Word, and Excel. Salary will vary between $25,000 to $30,000 each month. Housing and food will also included in the salary", tags: ["iOS", "Swift", "Front-end", "Back-end", "Software engineer", "Freshman", "Senior", "Personal project"]))
    }
    
    @objc func searchTapped() {
        
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsfeedViewController.posts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsfeedCell", for: indexPath) as! NewsfeedTableViewCell
        let tmp = NewsfeedViewController.posts![indexPath.row]
        cell.name = tmp.userName
        cell.date = tmp.date
        cell.company = tmp.companyName
        cell.content = tmp.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell as! NewsfeedTableViewCell
        tableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

extension NewsfeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsfeedViewController.posts![collectionView.tag].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
        
        cell.setLabel(tag: NewsfeedViewController.posts![collectionView.tag].tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(NewsfeedViewController.posts![collectionView.tag].tags[indexPath.item])
        
        return CGSize(width: width + 15, height: 20)
    }
}
