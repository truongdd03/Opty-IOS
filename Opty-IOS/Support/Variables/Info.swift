//
//  Info.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit
import Firebase

class Info: NSObject {
    var name = ""
    var birth = Date()
    var address = ""
    var country = ""
    var nation = ""
    var phone = ""
    var city = ""
    var state = ""
    
    init(name: String?, birth: Date, nation: String?, address: String?, city: String?, state: String?, country: String?, phone: String?) {
        self.name = name ?? ""
        self.birth = birth
        self.address = address ?? ""
        self.country = country ?? ""
        self.nation = nation ?? ""
        self.phone = phone ?? ""
        self.city = city ?? ""
        self.state = state ?? ""
    }
    
    func fetchData() {
        let uid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        
        db.collection("Basics").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            let dict = snapshot?.data() as! [String: String]
            
            print(dict)
            
            self.name = dict["name"] ?? ""
            self.birth = Date()
            self.address = dict["address"] ?? ""
            self.country = dict["country"] ?? ""
            self.nation = dict["nation"] ?? ""
            self.phone = dict["phone"] ?? ""
            self.city = dict["city"] ?? ""
            self.state = dict["state"] ?? ""
        }
    }
    
    func uploadData() {
        let db = Firestore.firestore()
        
        db.collection("Basics").document(Auth.auth().currentUser!.uid).setData([
            "name": self.name,
            "birth": "23102003",
            "address": self.address,
            "country": self.country,
            "nation": self.nation,
            "phone": self.phone,
            "city": self.city,
            "state": self.state
        ])
    }
}
