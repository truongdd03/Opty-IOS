//
//  Writer.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/4/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Writer {
    static let db = Firestore.firestore().collection("Information")

    static func writeDegree(degree: Degree) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Degrees").addDocument(from: degree)
        } catch {
            print("Error")
        }
    }
    
    static func writeAward(award: Award) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Awards").addDocument(from: award)
        } catch {
            print("Error")
        }
    }
    
    static func writeJob(job: Job) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Jobs").addDocument(from: job)
        } catch {
            print("Error")
        }
    }
    
    static func writeSkill(skill: Skill) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Skills").addDocument(from: skill)
        } catch {
            print("Error")
        }
    }
    
    static func writeTags() {
        let uid = Auth.auth().currentUser!.uid
        
        db.document(uid).collection("Tags").document("Tags").setData([
            "Tags": SkillsViewController.tags!
        ])
    }
    
    static func writePost(post: Post) -> String? {
        let uid = Auth.auth().currentUser!.uid
        do {
            let id = try Firestore.firestore().collection("Posts").addDocument(from: post).documentID
            let ref = Database.database().reference()
            AllPostsViewController.myPosts!.append(post)
            ref.child("Posts").child(uid).child(id).setValue(id)
            return id
        } catch {
            print("Error")
            return nil
        }
    }
    
    static func writeUsername(username: String) {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Usernames").document(uid).setData(["Username": username])
    }
}
