//
//  UserAPI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/15/23.
//

import Foundation
import FirebaseAuth
import Firebase
//import ProgressHUD

class UserApi {
    
    //returns the user ID of the user logged in
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    
    func createAccount(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        print("Step 1")
        Auth.auth().createUser(withEmail: email, password: password)
        { (AuthDataResult, error) in
            if error != nil {
                print("Step 2")
                //ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = AuthDataResult {
                print("Step 3")
                let dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email,
                    STATUS: "Welcome",
                    CREATED_DATE: Date().timeIntervalSince1970,
                    LAST_LOGIN_DATE: Date().timeIntervalSince1970,
                    USER_TYPE: 1
                ]
                Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: {
                    (error, ref) in
                    if error == nil {
                        print("Done")
                    }
                })
            }
            onSuccess()
        }
    }
    
    
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                //ProgressHUD.showSuccess("Reset link sent to your inbox")
            } else {
                onSuccess()
            }
        }
    }
    
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            //ProgressHUD.showError(error.localizedDescription)
            return
        }
        // (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()
    }
    
    func getUserInforSingleEvent(uid: String, onSuccess: @escaping(UserCompletion)) {
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let user = User.transformUser(dict: dict) {
                    onSuccess(user)
                }
            }
        }
    }
}

//Video 28
typealias UserCompletion = (User) -> Void

