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
    
    override init() {}
    
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
                        
            var dict = [String: Any]()
            if let tmp = snapshot?.data() {
                dict = tmp
            }
                                    
            let tmp = dict["birth"] as? Timestamp
            self.birth = tmp?.dateValue() ?? Date()
            
            self.name = dict["name"] as? String ?? ""
            self.address = dict["address"] as? String ?? ""
            self.country = dict["country"] as? String ?? ""
            self.nation = dict["nation"] as? String ?? ""
            self.phone = dict["phone"] as? String ?? ""
            self.city = dict["city"] as? String ?? ""
            self.state = dict["state"] as? String ?? ""
        }
    }
    
    func uploadData() {
        let db = Firestore.firestore()
        
        db.collection("Basics").document(Auth.auth().currentUser!.uid).setData([
            "name": self.name,
            "birth": self.birth, //reformatDateToString(date: self.birth),
            "address": self.address,
            "country": self.country,
            "nation": self.nation,
            "phone": self.phone,
            "city": self.city,
            "state": self.state
        ])
    }
}
