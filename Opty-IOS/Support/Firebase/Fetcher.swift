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

    static func fetchAll() {
        fetchInfo()
        fetchDegrees()
        fetchAwards()
        fetchJobs()
        fetchSkills()
        fetchUsername()
        fetchMyPosts()
    }

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
    
    static func fetchTags(completion: @escaping () -> Void) {
        let uid = Auth.auth().currentUser!.uid
        SkillsViewController.tags = []
        
        db.document(uid).collection("Tags").document("Tags").getDocument { (snapshot, err) in
            let dict = snapshot?.data() as? [String: [String]] ?? [String: [String]]()
            
            SkillsViewController.tags = dict["Tags"] ?? []
            Fetcher.fetchPostsSent {
                completion()
            }
        }
    }
    
    static func fetchUsername() {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Usernames").document(uid).getDocument { (snapshot, err) in
            let dict = snapshot?.data() as? [String: String] ?? [String: String]()
            HomepageViewController.username = dict["Username"]
        }
    }
    
    static func fetchPost(id: String, completion: @escaping (Post) -> Void) {
        if let post = posts[id] {
            completion(post)
            return
        }
    
        Firestore.firestore().collection("Posts").document(id).getDocument { (snapshot, err) in
            let tmp = try? snapshot?.data(as: Post.self)
            if tmp != nil {
                posts[id] = tmp
                completion(tmp!)
            }
        }
    }
    
    static func fetchApplicantsNumber(postID: String, completion: @escaping (Int) -> Void) {
        Database.database().reference().child("ApplicantsNumber").child(postID).getData { (err, snapshot) in
            let value = snapshot.value as? Int ?? 0
            completion(value)
        }
    }
    
    static func fetchMyPosts() {
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        AllPostsViewController.myPosts = []

        ref.child("Posts").child(uid).getData { (err, snapshot) in
            let dict = snapshot.value as? [String: String] ?? [String: String]()
            for key in dict.keys {
                fetchPost(id: key) { (post) in
                    fetchApplicantsNumber(postID: key) { (value) in
                        AllPostsViewController.myPosts?.append(MyPost(post: post, applicants: value))
                    }
                }
            }
        }
    }
    
    static func fetchPostID(keywords: [String], completion: @escaping ([String]) -> Void) {
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
            updatePostID(dict: dict, completion: completion)
        }
    }
    
    static func updatePostID(dict: [String: Int], completion: @escaping ([String]) -> Void) {
        var postsID = Array(dict.keys)
        postsID.sort() {
            dict[$0]! > dict[$1]!
        }
        
        print(postsID)
        
        // Fetch unrelevant posts
        Firestore.firestore().collection("Posts").getDocuments { (snapshot, err) in
            if let documents = snapshot?.documents {
                for document in documents {
                    let id = document.documentID
                    if dict[id] == nil {
                        postsID.append(id)
                    }
                }
                
                completion(postsID)
            }
        }
    }
    
    static func fetchPostsSent(completion: @escaping () -> Void) {
        NewsfeedViewController.postsSent = [String]()
        let uid = Auth.auth().currentUser!.uid
        Database.database().reference().child("AppliedPosts").child(uid).getData { (err, snapshot) in
            let dict = snapshot.value as? [String: String] ?? [String: String]()
            for key in dict.keys {
                NewsfeedViewController.postsSent?.append(key)
            }
            
            completion()
        }
    }
    
    static func fetchApplicants(postID: String, completion: @escaping ([String]) -> Void) {
        Database.database().reference().child("Applicants").child(postID).getData { (err, snapshot) in
            let dict = snapshot.value as? [String: String] ?? [String:String]()
            let keys = Array(dict.keys)
            completion(keys)
        }
    }
    
    static func fetchResume(id: String, completion: @escaping (Post) -> Void) {
        Firestore.firestore().collection("Resumes").document(id).getDocument { (snapshot, err) in
            let post = try! snapshot?.data(as: Post.self)
            completion(post!)
        }
    }
}
