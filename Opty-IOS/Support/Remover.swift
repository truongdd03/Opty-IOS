//
//  Remover.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/4/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Remover {
    static let db = Firestore.firestore().collection("Education")

    static func removeDegree(degree: Degree) {
        let uid = Auth.auth().currentUser!.uid
        if let id = degree.id {
            db.document(uid).collection("Degrees").document(id).delete()
        }
    }
    
    static func removeAward(award: Award) {
        let uid = Auth.auth().currentUser!.uid
        if let id = award.id {
            db.document(uid).collection("Awards").document(id).delete()
        }
    }
    
    static func removeJob(job: Job) {
        let uid = Auth.auth().currentUser!.uid
        if let id = job.id {
            db.document(uid).collection("Jobs").document(id).delete()
        }
    }
}
