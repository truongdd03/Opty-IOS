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
    static let db = Firestore.firestore().collection("Education")

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
        }
    }
    
    static func fetchUsername() {
        let ddb = Firestore.firestore().collection("Usernames")
        let uid = Auth.auth().currentUser!.uid
        
        ddb.document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            let dict = snapshot?.data() as? [String: String] ?? [String: String]()
            NewpostViewController.username = dict["username"] ?? ""
        }
    }
}
