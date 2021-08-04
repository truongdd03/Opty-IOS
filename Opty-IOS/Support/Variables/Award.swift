//
//  Award.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit
import FirebaseFirestoreSwift

class Award: NSObject, Codable {
    var name: String
    var content: String
    
    init(name: String, content: String) {
        self.name = name
        self.content = content
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case content
    }
}
