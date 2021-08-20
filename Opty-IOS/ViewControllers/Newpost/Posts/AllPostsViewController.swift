//
//  AllPostsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/11/21.
//

import UIKit

class AllPostsViewController: UIViewController {
    static var myPosts: [MyPost]?
    
    @IBOutlet weak var PostsTableView: UITableView!
    @IBOutlet weak var BottomView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your posts"
        
        PostsTableView.delegate = self
        PostsTableView.dataSource = self
        PostsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension AllPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllPostsViewController.myPosts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = AllPostsViewController.myPosts![indexPath.row].post
                
        cell.address = post.address
        cell.company = post.title
        cell.content = post.content
        cell.applicantsNumber = AllPostsViewController.myPosts![indexPath.row].applicants
        cell.date = post.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let str = AllPostsViewController.myPosts![indexPath.row].post.content
        let width = view.frame.size.width - 20
        let height = str.height(withConstrainedWidth: width, font: .systemFont(ofSize: 14))
        return min(height + 120, 300)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let id = AllPostsViewController.myPosts![indexPath.row].post.id!
        Fetcher.fetchApplicants(postID: id) { (postsID) in
            let storyBoard = UIStoryboard(name: "Newsfeed", bundle: nil)
            
            print(postsID)
            DispatchQueue.main.async {
                let vc = storyBoard.instantiateViewController(identifier: "Newsfeed") as! NewsfeedViewController
                vc.postsID = postsID
                vc.name = "Applicants"
                vc.isApplicant = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = AllPostsViewController.myPosts![indexPath.row].post
            
            AllPostsViewController.myPosts!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            Remover.removePost(id: post.id!)
            Index.updatePost(tags: post.tags, content: post.content, postID: post.id!, isDelete: true)
        }
    }
        
}
