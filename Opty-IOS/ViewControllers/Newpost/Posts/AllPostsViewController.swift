//
//  AllPostsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/11/21.
//

import UIKit

class AllPostsViewController: UIViewController {
    static var myPosts: [Post]? = []
    
    @IBOutlet weak var PostsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your posts"
        
        PostsTableView.delegate = self
        PostsTableView.dataSource = self
        
        for _ in 0...3 {
            AllPostsViewController.myPosts?.append(Post(userName: "Don", date: "23/10/2003", companyName: "Facebook", content: "Fetch Technology Vietnam is a comprehensive global provider of HR and Talent Acquisition Services, focusing primarily in the technology fields. Founded in 2016, Fetch Technology Vietnam helps foreign companies of all types and sizes reach their potential by providing the talent and support to efficiently build and scale a high-performing, distributed workforce in Vietnam.Our mission is to offer Vietnam’s most talented technologists a platform to connect with some of the world’s leading tech companies and build their expertise on a global scale. Over 4 years, Fetch has built a good reputation and is trusted by many Vietnamese and foreign companies; And Fetch will continue its good work to bridge the divide between the World and the Vietnam Tech sector.", tags: [], address: "dkfja", applicantsNumber: 100))
        }        
    }
}

extension AllPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllPostsViewController.myPosts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = AllPostsViewController.myPosts![indexPath.row]
                
        cell.address = post.address
        cell.applicantsNumber = post.applicantsNumber
        cell.company = post.companyName
        cell.content = post.content
        cell.date = post.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let str = AllPostsViewController.myPosts![indexPath.row].content
        let width = view.frame.size.width - 20
        let height = str.height(withConstrainedWidth: width, font: .systemFont(ofSize: 14))
        return min(height + 120, 300)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard = UIStoryboard(name: "Newpost", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Applicants") as! ApplicantsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
