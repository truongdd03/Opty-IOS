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
            
            var dict = [String: String]()
            if let tmp = snapshot?.data() as? [String: String] {
                dict = tmp
            }
                        
            self.name = dict["name"] ?? ""
            self.birth = self.reformatStringToDate(str: dict["birth"] ?? "")
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
            "birth": reformatDateToString(date: self.birth),
            "address": self.address,
            "country": self.country,
            "nation": self.nation,
            "phone": self.phone,
            "city": self.city,
            "state": self.state
        ])
    }
    
    func reformatDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: date)
    }
    
    func reformatStringToDate(str: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: str) ?? Date()
        return date
    }
}
