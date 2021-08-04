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
}
