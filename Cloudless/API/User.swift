//
//  User.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/15/23.
//

import Foundation

class User {
    var uid: String
    var email: String
    var status: String
    var createdDate: Double
    var lastLoginDate: Double
    var userType: Int

    
    init(uid: String, email: String, status: String, createdDate: Double, lastLoginDate: Double, userType: Int) {
        self.uid = uid
        self.email = email
        self.status = status
        self.createdDate = createdDate
        self.lastLoginDate = lastLoginDate
        self.userType = userType
    }
    
    //The method that excepts the dictionary and turns it into the users varaible
    static func transformUser(dict: [String: Any]) -> User? {
        guard let email = dict["email"] as? String,
        let status = dict["status"] as? String,
        let createdDate = dict["createdDate"] as? Double,
        let lastLoginDate = dict["lastLoginDate"] as? Double,
        let userType = dict["userType"] as? Int,
        let uid = dict["uid"] as? String
        else {
            return nil
        }
        //assign all of the unwrapped data to the instnce user, and return the full user at the end
        let user = User (uid: uid, email: email, status: status, createdDate: createdDate, lastLoginDate: lastLoginDate, userType: userType)
        print("user IDs from API: \(user.uid)")
        return user
    }
}

