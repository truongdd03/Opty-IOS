//
//  Data.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/4/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Fetcher {
    static let db = Firestore.firestore().collection("Information")
    static var posts = [String: Post]()

    static func fetchInfo() {
        BasicsViewController.basicInfo = Info()
        BasicsViewController.basicInfo!.fetchData()
    }

    static func fetchDegrees() {
        let uid = Auth.auth().currentUser!.uid
        EducationViewController.degrees = []
        
        db.document(uid).collection("Degrees").getDocuments { (snapshot, err) in
            
            if let documents = snapshot?.documents {
                EducationViewController.degrees! = documents.compactMap({ (querySnapshot) -> Degree? in
                    let tmp = try? querySnapshot.data(as: Degree.self)
                    return tmp
                })
            }
        }
    }
    
    static func fetchAwards() {
        let uid = Auth.auth().currentUser!.uid
        EducationViewController.awards = []
        
        db.document(uid).collection("Awards").getDocuments { (snapshot, err) in
            
            if let documents = snapshot?.documents {
                EducationViewController.awards! = documents.compactMap({ (querySnapshot) -> Award? in
                    let tmp = try? querySnapshot.data(as: Award.self)
                    return tmp
                })
            }
        }
    }
    
    static func fetchJobs() {
        let uid = Auth.auth().currentUser!.uid
        ExperienceViewController.jobs = []
        
        db.document(uid).collection("Jobs").getDocuments { (snapshot, err) in
            
            if let documents = snapshot?.documents {
                ExperienceViewController.jobs! = documents.compactMap({ (querySnapshot) -> Job? in
                    let tmp = try? querySnapshot.data(as: Job.self)
                    return tmp
                })
            }
        }
    }
    
    static func fetchSkills() {
        let uid = Auth.auth().currentUser!.uid
        SkillsViewController.skills = []
        
        db.document(uid).collection("Skills").getDocuments { (snapshot, err) in
            
            if let documents = snapshot?.documents {
                SkillsViewController.skills! = documents.compactMap({ (querySnapshot) -> Skill? in
                    let tmp = try? querySnapshot.data(as: Skill.self)
                    return tmp
                })
            }
        }
    }
    
    static func fetchTags() {
        let uid = Auth.auth().currentUser!.uid
        SkillsViewController.tags = []
        
        db.document(uid).collection("Tags").document("Tags").getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            let dict = snapshot?.data() as? [String: [String]] ?? [String: [String]]()
            
            SkillsViewController.tags = dict["Tags"] ?? []
            fetchPostID(keywords: SkillsViewController.tags!)
        }
    }
    
    static func fetchUsername() {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Usernames").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            let dict = snapshot?.data() as! [String: String]
            HomepageViewController.username = dict["Username"]
        }
    }
    
    static func fetchPost(id: String, completion: @escaping (Post) -> Void) {
        if let post = posts[id] {
            print(post)
            completion(post)
            return
        }
    
        Firestore.firestore().collection("Posts").document(id).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            print("Fetcing \(id)")
            
            let tmp = try? snapshot?.data(as: Post.self)
            if tmp != nil {
                posts[id] = tmp
                completion(tmp!)
            }
        }
    }
    
    static func fetchMyPosts() {
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        AllPostsViewController.myPosts = []

        ref.child("Posts").child(uid).getData { (err, snapshot) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
                        
            for child in snapshot.children {
                let documentID = (child as! DataSnapshot).value as! String
                fetchPost(id: documentID) { (post) in
                    AllPostsViewController.myPosts?.append(post)
                }
            }
        }
    }
    
    static func fetchPostID(keywords: [String]) {
        let ddb = Database.database().reference().child("Dict")
        var dict = [String: Int]()
        
        let group = DispatchGroup()
        
        for tag in keywords {
            group.enter()
            ddb.child(tag).getData { (err, snapshot) in
                let data = snapshot.value as? [String: Int] ?? [String: Int]()
                for key in data.keys {
                    dict[key] = (dict[key] ?? 0) + data[key]!
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            updatePostID(dict: dict)
        }
    }
    
    static func updatePostID(dict: [String: Int]) {
        NewsfeedViewController.postsID = Array(dict.keys)
        NewsfeedViewController.postsID.sort() {
            dict[$0]! > dict[$1]!
        }
        
        // Fetch unrelevant posts
        Firestore.firestore().collection("Posts").getDocuments { (snapshot, err) in
            if let documents = snapshot?.documents {
                for document in documents {
                    let id = document.documentID
                    if dict[id] == nil {
                        NewsfeedViewController.postsID.append(id)
                    }
                }
            }
            
            for i in 0...5 {
                NewsfeedViewController.loadNext(index: i)
            }
        }
    }
}
