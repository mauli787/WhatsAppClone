//
//  ListViewModel.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 14/01/21.
//

import UIKit

class APIManager {
    var users: [ListUser] = []
    init() {
        
    }
    func getArticles(completion: @escaping ([ListUser]?) -> ()) {
        
        let person1: ListUser = ListUser(user_name: "Dnyanesh", user_profile: Constant().profileUrl, user_message: "Hi", day_useronline: "Monday")
        let person2: ListUser = ListUser(user_name: "Jay", user_profile: Constant().profileUrl, user_message: "Hi", day_useronline: "Tuesday")
        let person3: ListUser = ListUser(user_name: "Vinod", user_profile: Constant().profileUrl, user_message: "Hi", day_useronline: "Wensday")
        let person4: ListUser = ListUser(user_name: "Akshay", user_profile: Constant().profileUrl, user_message: "Hi", day_useronline: "Wensday")
        let person5: ListUser = ListUser(user_name: "Rahul", user_profile: Constant().profileUrl, user_message: "Hi", day_useronline: "Thursday")
        
        users.append(person1)
        users.append(person2)
        users.append(person3)
        users.append(person4)
        users.append(person5)
        completion(users)
    }
}


struct UserListViewModel {
    var users: [ListUser]
}
extension UserListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.users.count
    }
    func userAtIndex(_ index: Int) -> UsersViewModel {
        let list = self.users[index]
        return UsersViewModel(list)
    }
}

struct UsersViewModel {
    private let user: ListUser
}

extension UsersViewModel {
    init(_ user: ListUser) {
        self.user = user
    }
}

extension UsersViewModel {
    
    var userName: String {
        return self.user.userName
    }    
    var userMessage: String {
        return self.user.userMessage
    }
    var userProfileURL: String {
        return self.user.userProfile
    }
    var userdayOnline: String {
        return self.user.dayUserOnline
    }
}


