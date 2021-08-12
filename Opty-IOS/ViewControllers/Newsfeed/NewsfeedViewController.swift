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
    
    var index = -1
    var clicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle"), style: .plain, target: self, action: #selector(searchTapped))
                
        title = "Opty"
        
        NewsfeedTableView.delegate = self
        NewsfeedTableView.dataSource = self
        
        for _ in 0...3 {
            NewsfeedViewController.posts?.append(Post(userName: "Don Truong", date: "23/10/21", companyName: "Facebook", content: "We need a software developer", tags: ["iOS", "Swift", "Front-end"], address: "", applicantsNumber: 0))
        }
        
        NewsfeedViewController.posts?.append(Post(userName: "Don Truong", date: "23/10/21", companyName: "Facebook", content: "Fetch Technology Vietnam is a comprehensive global provider of HR and Talent Acquisition Services, focusing primarily in the technology fields. Founded in 2016, Fetch Technology Vietnam helps foreign companies of all types and sizes reach their potential by providing the talent and support to efficiently build and scale a high-performing, distributed workforce in Vietnam.Our mission is to offer Vietnam’s most talented technologists a platform to connect with some of the world’s leading tech companies and build their expertise on a global scale. Over 4 years, Fetch has built a good reputation and is trusted by many Vietnamese and foreign companies; And Fetch will continue its good work to bridge the divide between the World and the Vietnam Tech sector.", tags: ["iOS", "Swift", "Front-end", "Back-end", "Software engineer", "Freshman", "Senior", "Personal project"], address: "", applicantsNumber: 0))
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
        cell.address = tmp.address
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if index == indexPath.row {
            clicked = !clicked
        } else {
            clicked = false
        }
        index = indexPath.row
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell as! NewsfeedTableViewCell
        tableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let str = NewsfeedViewController.posts![indexPath.row].content
        let width = view.frame.size.width - 20
        let height = str.height(withConstrainedWidth: width, font: .systemFont(ofSize: 14))
        
        if index == indexPath.row && !clicked {
            return height + 160
        }
                
        return min(height + 160, 300)
    }

}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return boundingBox.height
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
