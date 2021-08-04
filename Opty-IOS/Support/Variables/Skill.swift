//
//  Skill.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/2/21.
//

import UIKit
import FirebaseFirestoreSwift

class Skill: NSObject, Codable {
    @DocumentID var id: String?
    var name = ""
    var content = ""
    
    init(name: String, content: String) {
        self.name = name
        self.content = content
    }
}
