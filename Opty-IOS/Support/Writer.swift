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
    static let db = Firestore.firestore().collection("Education")

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
}
