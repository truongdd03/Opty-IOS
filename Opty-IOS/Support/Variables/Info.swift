//
//  Info.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

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
    
}
