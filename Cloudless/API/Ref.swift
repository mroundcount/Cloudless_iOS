//
//  Ref.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/13/23.
//

import Foundation
import Firebase

//Storage and database references
let REF_USER = "users"
let REF_SUBMITTED_NUMBER = "submittedNumbers"

//App info for landing page
let IDENTIFIER_WELCOME = "WelcomeVC"
let IDENTIFIER_TABBAR = "TabBarVC"

//Viewcontroller references
let IDENTIFIER_SIGN_IN = "SignInViewController"
let IDENTIFIER_SIGN_UP = "SignUpViewController"
let IDENTIFIER_FORGOT_PASSWORD = "ForgotPasswordViewController"
let IDENTIFIER_HOME_PAGE = "HomeViewController"
let IDENTIFIER_PROFILE_OPTIONS = "ProfileOptionsTableViewController"
let IDENTIFIER_SUBMIT = "SubmitNumberViewController"
let IDENTIFIER_SEARCH = "SearchNumberViewController"

//User profile attributes
let UID = "uid"
let EMAIL = "email"
let STATUS = "status"
let CREATED_DATE = "createdDate"
let LAST_LOGIN_DATE = "lastLoginDate"
let USER_TYPE = "userType"

//Error handling
let ERROR_EMPTY_EMAIL = "Please enter an email address"
let ERROR_EMPTY_PASSWORD = "Please enter a password"
let ERROR_EMPTY_EMAIL_RESET = "Please enter an email address to reset your password"
let SUCCESS_EMAIL_RESET = "We have just resent you a password. Please check your inbox"
let ERROR_EMPTY_SEARCH = "Please enter a phone number"
let ERROR_INVALID_NUMBER = "Please enter a valid 10 digit number"
let ERROR_INVALID_RELATIONSHIP_STATUS = "Please select a relationship status"


class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    //User tables
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    //method for taking a user id as a parameter to get the reference node
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    //SubmittedNumbers table
    func databaseSubmittedNumber() -> DatabaseReference {
        return databaseRoot.child(REF_SUBMITTED_NUMBER)
    }

}
