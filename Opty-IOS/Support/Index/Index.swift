//
//  index.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/13/21.
//

import Foundation
import Firebase

class Index {
    static let db = Database.database().reference().child("Dict")
    
    static func addWord(word: String, times: Int, postID: String) {
        db.child(word).child(postID).setValue(times)
    }
    
    static func updatePost(tags: [String], content: String, postID: String) {
        for tag in tags {
            addWord(word: tag, times: 10, postID: postID)
        }
    }
    
    static func removeWord(word: String, postID: String) {
        db.child(word).child(postID).removeValue()
    }
    
    static func removePost(tags: [String], content: String, postID: String) {
        for tag in tags {
            removeWord(word: tag, postID: postID)
        }
    }
}
