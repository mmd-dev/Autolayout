//
//  user.swift
//  Autolayout
//
//  Created by yanyin on 17/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login (login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
       return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "Shadow", company: "Apple", login: "sApple", password: "12345"),
            User(name: "Leo", company: "Pear", login: "lPear", password: "123456")
            ]{
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}
