//
//  ResultClass.swift
//  DemoSEAPI
//
//  Created by ashiq on 16/03/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import Foundation
class SearchResult {
    
    var profileImage = ""
    var name = ""
    var question = ""
    var tags = ""
    
    init(profileImage:String, name: String, question: String, tags:String) {
        self.profileImage = profileImage
        self.name = name
        self.question = question
        self.tags = tags
    }
    
}