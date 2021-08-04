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
                    if tmp != nil {
                        tmp!.id = querySnapshot.documentID
                    }
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
                    if tmp != nil {
                        tmp!.id = querySnapshot.documentID
                    }
                    return tmp
                })
            }
        }
    }
}
