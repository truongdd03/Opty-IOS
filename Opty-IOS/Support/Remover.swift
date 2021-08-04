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
}
