//
//  Post.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/5/21.
//

import UIKit
import FirebaseFirestoreSwift
import Firebase

class MyPost: NSObject {
    var post: Post
    var applicants: Int
    
    init(post: Post, applicants: Int) {
        self.post = post
        self.applicants = applicants
    }
}

class Post: NSObject, Codable {
    @DocumentID var id: String?
    var userName: String
    var date: String
    var title: String
    var content: String
    var tags: [String]
    var address: String
    
    override init() {
        self.userName = ""
        self.date = ""
        self.title = ""
        self.content = ""
        self.address = ""
        self.tags = []
    }
        
    init(userName: String, date: String, title: String, content: String, tags: [String], address: String) {
        self.userName = userName
        self.date = date
        self.title = title
        self.content = content
        self.tags = tags
        self.address = address
    }
    
    func updateDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
    }
    
    func createResume() {
        self.date = Utilities.reformatDate(date: BasicsViewController.basicInfo!.birth, format: "yyyy/MM/dd")
    }
}
