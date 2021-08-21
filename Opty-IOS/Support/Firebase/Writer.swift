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
            writeResume()
        } catch {
            print("Error")
        }
    }
    
    static func writeAward(award: Award) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Awards").addDocument(from: award)
            writeResume()
        } catch {
            print("Error")
        }
    }
    
    static func writeJob(job: Job) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Jobs").addDocument(from: job)
            writeResume()
        } catch {
            print("Error")
        }
    }
    
    static func writeSkill(skill: Skill) {
        let uid = Auth.auth().currentUser!.uid
        
        do {
            let _ = try db.document(uid).collection("Skills").addDocument(from: skill)
            writeResume()
        } catch {
            print("Error")
        }
    }
    
    static func writeTags() {
        let uid = Auth.auth().currentUser!.uid
        
        db.document(uid).collection("Tags").document("Tags").setData([
            "Tags": SkillsViewController.tags!
        ])
        writeResume()
    }
    
    static func writePost(post: Post) -> String? {
        let uid = Auth.auth().currentUser!.uid
        do {
            let id = try Firestore.firestore().collection("Posts").addDocument(from: post).documentID
            Database.database().reference().child("Posts").child(uid).child(id).setValue(id)
            return id
        } catch {
            print("Error")
            return nil
        }
    }
    
    static func writeUsername(username: String) {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Usernames").document(uid).setData(["Username": username])
        //writeResume()
    }
    
    static func writeApplicants(postID: String) {
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        ref.child("Applicants").child(postID).child(uid).setValue(uid)
        ref.child("AppliedPosts").child(uid).child(postID).setValue(postID)
        ref.child("ApplicantsNumber").child(postID).getData { (err, snapshot) in
            let val = snapshot.value as? Int ?? 0
            ref.child("ApplicantsNumber").child(postID).setValue(val + 1)
        }
    }
    
    static func writeResume() {
        let uid = Auth.auth().currentUser!.uid
        let resume = Post()
        resume.createResume()
        
        print(resume.content)
        try? Firestore.firestore().collection("Resumes").document(uid).setData(from: resume)
    }
}
