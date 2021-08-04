//
//  Degree.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Degree: NSObject, Codable {
    var school: String
    var startDate: String
    var endDate: String
    var degree: String
    
    enum CodingKeys: String, CodingKey {
        case school
        case startDate
        case endDate
        case degree
    }
        
    init(school: String, degree: String, startDate: String, endDate: String) {
        self.school = school
        self.degree = degree
        self.startDate = startDate
        self.endDate = endDate
    }
}
