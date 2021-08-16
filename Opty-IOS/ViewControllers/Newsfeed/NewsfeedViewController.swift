//
//  NewsfeedViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit

class NewsfeedViewController: UIViewController {

    @IBOutlet weak var NewsfeedTableView: UITableView!
    
    static var posts: [Post] = [Post]()
    static var postsID: [String] = []
    
    var index = -1
    var clicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle"), style: .plain, target: self, action: #selector(searchTapped))
                
        title = "Opty"
        
        NewsfeedTableView.delegate = self
        NewsfeedTableView.dataSource = self
        NewsfeedTableView.prefetchDataSource = self
        NewsfeedTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        fetchData {
            for i in 0...2 {
                self.loadNext(index: i)
            }
        }
    }
    
    func fetchData(completion: @escaping () -> Void) {
        if BasicsViewController.basicInfo == nil {
            Fetcher.fetchTags(completion: completion)
            Fetcher.fetchInfo()
            Fetcher.fetchDegrees()
            Fetcher.fetchAwards()
            Fetcher.fetchJobs()
            Fetcher.fetchSkills()
            Fetcher.fetchUsername()
        }
        
        if AllPostsViewController.myPosts == nil {
            Fetcher.fetchMyPosts()
        }
    }
    
    @objc func searchTapped() {
        
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for id in indexPaths {
            loadNext(index: id.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsfeedViewController.posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == NewsfeedViewController.posts.count {
            return UITableViewCell()
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsfeedCell", for: indexPath) as! NewsfeedTableViewCell
        
        let tmp = NewsfeedViewController.posts[indexPath.row]
        cell.name = tmp.userName
        cell.date = tmp.date
        cell.company = tmp.companyName
        cell.content = tmp.content
        cell.address = tmp.address
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == NewsfeedViewController.posts.count {
            return 0
        }
    
        if indexPath.row < NewsfeedViewController.posts.count {
            let str = NewsfeedViewController.posts[indexPath.row].content
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
        if index >= NewsfeedViewController.postsID.count { return }
        if index < NewsfeedViewController.posts.count { return }
        
        print(index)
           
        Fetcher.fetchPost(id: NewsfeedViewController.postsID[index]) { (post) in
            DispatchQueue.main.async {
                NewsfeedViewController.posts.append(post)
                self.NewsfeedTableView.reloadData()
            }
        }
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
        return NewsfeedViewController.posts[collectionView.tag].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionViewCell
        
        cell.setLabel(tag: NewsfeedViewController.posts[collectionView.tag].tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Utilities.sizeOfLabel(NewsfeedViewController.posts[collectionView.tag].tags[indexPath.item])
        
        return CGSize(width: width + 15, height: 20)
    }
}
