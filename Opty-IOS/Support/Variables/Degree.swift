//
//  Degree.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import Foundation

class Degree: NSObject {
    var school = ""
    var startDate = ""
    var endDate = ""
    var degree = ""
    
    init(school: String, degree: String, startDate: String, endDate: String) {
        self.school = school
        self.degree = degree
        self.startDate = startDate
        self.endDate = endDate
    }
}
