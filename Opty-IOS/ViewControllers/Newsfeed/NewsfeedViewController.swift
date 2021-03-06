//
//  NewsfeedViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class NewsfeedViewController: UIViewController {
    @IBOutlet weak var NewsfeedTableView: UITableView!
    
    static var postsSent: [String]?
    
    var posts: [Post] = [Post]()
    var postsID: [String] = []
    var isApplicant = false
    var name = "Opty"
    var postID: String?
    
    var index = -1
    var clicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle"), style: .plain, target: self, action: #selector(searchTapped))
        title = name
        
        setUp()
    }
    
    func setUp() {
        NewsfeedTableView.delegate = self
        NewsfeedTableView.dataSource = self
        NewsfeedTableView.prefetchDataSource = self
        NewsfeedTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNewsfeed), name: NSNotification.Name(rawValue: "loadNewsfeed"), object: nil)
        
        fetchData()
    }
    
    @objc func loadNewsfeed() {
        NewsfeedTableView.reloadData()
    }
    
    func fetchData() {
        if SkillsViewController.tags == nil {
            Fetcher.fetchTags {
                Fetcher.fetchPostID(keywords: SkillsViewController.tags!) { (ids) in
                    self.postsID = ids
                    
                    print(self.postsID)
                    
                    for i in 0...5 {
                        self.loadNext(index: i)
                    }
                }
            }
            Fetcher.fetchAll()
        } else {
            for i in 0...5 {
                self.loadNext(index: i)
            }
        }
    }
    
    @objc func searchTapped() {
        let storyBoard = UIStoryboard(name: "Newsfeed", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "NewsfeedSearch")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for id in indexPaths {
            loadNext(index: id.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == posts.count {
            return UITableViewCell()
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsfeedCell", for: indexPath) as! NewsfeedTableViewCell
        let tmp = posts[indexPath.row]
        
        cell.id = tmp.id
        cell.postID = postID
        cell.name = tmp.userName
        cell.date = tmp.date
        cell.title = tmp.title
        cell.content = tmp.content
        cell.address = tmp.address
        cell.selectionStyle = .none
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        if isApplicant {
            cell.buttonTitle = "Reject"
            cell.buttonClicked = false
        } else {
            cell.buttonTitle = "Send resume"
            cell.buttonClicked = (NewsfeedViewController.postsSent!.contains(postsID[indexPath.row
            ]))
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == posts.count {
            return 0
        }
    
        if indexPath.row < posts.count {
            let str = posts[indexPath.row].content
            let width = view.frame.size.width - 20
            let height = str.height(withConstrainedWidth: width, font: .systemFont(ofSize: 14))
        
            if index == indexPath.row && !clicked {
                return height + 160
            }
                
            return min(height + 160, 300)
        }
        return 50
    }

    func loadNext(index: Int) {
        if index >= postsID.count { return }
        if index < posts.count { return }
        
        posts.append(Post())
        print(index)
        
        if isApplicant {
            Fetcher.fetchResume(id: postsID[index]) { (post) in
                self.posts[index] = post
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadNewsfeed"), object: nil)
                }
            }
        } else {
            Fetcher.fetchPost(id: postsID[index]) { (post) in
                self.posts[index] = post
                //print(self.postsID[index], post.id)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadNewsfeed"), object: nil)
                }
            }
        }
    }
}

extension NewsfeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts[collectionView.tag].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
        
        cell.setLabel(tag: posts[collectionView.tag].tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(posts[collectionView.tag].tags[indexPath.item])
        
        return CGSize(width: width + 15, height: 20)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return boundingBox.height
    }
}
