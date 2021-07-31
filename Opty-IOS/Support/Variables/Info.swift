//
//  Info.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class Info: NSObject {
    var name = ""
    var birth = ""
    var address = ""
    var country = ""
    var nation = ""
    var phone = ""
    init(name: String, birth: String, nation: String, address: String, country: String, phone: String) {
        self.name = name
        self.birth = birth
        self.address = address
        self.country = country
        self.nation = nation
        self.phone = phone
    }
}
