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
    
    static func validate(word: String) -> Bool {
        if word.count <= 2 { return false }
        for chr in word {
            if !chr.isLetter {
                return false
            }
        }
        return true
    }
    
    static func simplify(words: [String]) -> [String] {
        var res = words
        var id = 0
        while id < res.count {
            if !validate(word: res[id]) {
                res.remove(at: id)
            } else {
                // stem here
                id += 1
            }
        }
        return res
    }
    
    static func splitContent(content: String) -> [String] {
        var res = [String]()
        let seperators = CharacterSet(charactersIn: " \n")
        
        res = content.components(separatedBy: seperators)
        for id in 0..<res.count {
            res[id] = res[id].lowercased()

            if res[id].count > 0 && !res[id].first!.isLetter {
                res[id].removeFirst()
            }
            if res[id].count > 0 && !res[id].last!.isLetter {
                res[id].removeLast()
            }
        }
        
        res = simplify(words: res)
        res.sort()
        return res
    }
    
    static func addWord(word: String, times: Int, postID: String) {
        db.child(word).child(postID).setValue(times)
    }
    
    static func removeWord(word: String, postID: String) {
        db.child(word).child(postID).removeValue()
    }
    
    static func updatePost(tags: [String], content: String, postID: String, isDelete: Bool) {
        updateTags(tags: tags, postID: postID, isDelete: isDelete)
        
        var words = splitContent(content: content)
        words.append("~_~")
        var times = 1
        
        print(words)
        for id in 1..<words.count {
            if words[id] != words[id-1] {
                if !isDelete {
                    addWord(word: words[id-1], times: times, postID: postID)
                } else {
                    removeWord(word: words[id-1], postID: postID)
                }
                times = 1
            } else {
                times += 1
            }
        }
    }
    
    static func updateTags(tags: [String], postID: String, isDelete: Bool) {
        for tag in tags {
            if !isDelete {
                addWord(word: tag, times: 10, postID: postID)
            } else {
                removeWord(word: tag, postID: postID)
            }
        }
    }
}
