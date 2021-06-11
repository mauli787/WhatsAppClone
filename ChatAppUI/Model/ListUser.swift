//
//  ListOfUsers.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 14/01/21.
//

import Foundation

struct ListUser : Codable {
    var userName : String!
    var userProfile : String!
    var userMessage: String!
    var dayUserOnline : String!
    
    init(user_name:String,user_profile:String,user_message:String,day_useronline:String) {
        self.userName = user_name
        self.userProfile = user_profile
        self.userMessage = user_message
        self.dayUserOnline = day_useronline
    }
}
