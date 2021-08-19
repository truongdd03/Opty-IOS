//
//  Post.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit
import FirebaseFirestoreSwift

class Post: NSObject, Codable {
    @DocumentID var id: String?
    var userName: String
    var date: String
    var title: String
    var content: String
    var tags: [String]
    var address: String
    var applicantsNumber: Int
    
    override init() {
        self.userName = ""
        self.date = ""
        self.title = ""
        self.content = ""
        self.address = ""
        self.applicantsNumber = 0
        self.tags = []
    }
        
    init(userName: String, date: String, title: String, content: String, tags: [String], address: String, applicantsNumber: Int) {
        self.userName = userName
        self.date = date
        self.title = title
        self.content = content
        self.tags = tags
        self.address = address
        self.applicantsNumber = applicantsNumber
    }
    
    func updateDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
    }
}
