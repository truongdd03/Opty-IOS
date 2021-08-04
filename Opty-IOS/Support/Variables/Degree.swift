//
//  Degree.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import Foundation
import Firebase

class Degree: NSObject {
    var school = ""
    var startDate = ""
    var endDate = ""
    var degree = ""
    
    init(school: String, degree: String, startDate: String, endDate: String) {
        self.school = school
        self.degree = degree
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func fetchData() {
        let db = Firestore.firestore()

        db.collection("Degrees").document(Auth.auth().currentUser!.uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            var dict = [String: String]()
            if let tmp = snapshot?.data() as? [String: String] {
                dict = tmp
            }
            
            self.school = dict["school"]!
            self.startDate = dict["startDate"]!
            self.endDate = dict["endDate"]!
            self.degree = dict["degree"]!
        }
    }
    
    func uploadData() {
        let db = Firestore.firestore()
        
        db.collection("Degrees").document(Auth.auth().currentUser!.uid).setData([
            "school": self.school,
            "startDate": self.startDate,
            "endDate": self.endDate,
            "degree": self.degree
        ])
    }
}
