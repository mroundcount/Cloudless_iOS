//
//  SubmittedNumberAPI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/17/23.
//

import Foundation
import Firebase


class SubmittedNumberAPI {

    func uploadPhoneRecord(value: Dictionary<String, Any>) {
        let ref = Ref().databaseSubmittedNumber()
        ref.childByAutoId().updateChildValues(value)
    }
    
    //Checking to see if I have ever uploaded a record.
    func lookForMyRecords(userID: String) {
        let ref = Database.database().reference().child("submittedNumbers")
        ref.queryOrdered(byChild: "submitterID").queryEqual(toValue: userID)
            .observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.exists() else{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setUpNoRecord"), object: nil)
                return
            }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setUpUpdateRecord"), object: nil)
        })
    }
    
    //Loading the record that I have submitted.
    func loadMyRecords(userID: String, onSuccess: @escaping(SubmittedNumber) -> Void) {
        let ref = Database.database().reference().child("submittedNumbers")
        ref.queryOrdered(byChild: "submitterID").queryEqual(toValue: userID).observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String : AnyObject] {
                if let submittedNumber = SubmittedNumber.transformSubmittedNumber(dict: dict, keyId: snapshot.key) {
                    onSuccess(submittedNumber)
                }
            }
        })
    }


    //Function that searches for phone numbers that others have entered.
    func loadSearchRecord(submittedNumber: String, onSuccess: @escaping(SubmittedNumber) -> Void) {
        let ref = Database.database().reference().child("submittedNumbers")
        ref.queryOrdered(byChild: "sumbittedNumber").queryEqual(toValue: submittedNumber).observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String : AnyObject] {
                if let submittedNumber = SubmittedNumber.transformSubmittedNumber(dict: dict, keyId: snapshot.key) {
                    onSuccess(submittedNumber)
                }
            }
        })
        
        ref.queryOrdered(byChild: "sumbittedNumber").queryEqual(toValue: submittedNumber)
            .observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.exists() else{
                //https://stackoverflow.com/questions/42135402/calling-function-from-another-viewcontroller-in-swift
                NotificationCenter.default.post(name: Notification.Name(rawValue: "noResultsFound"), object: nil)
                return
            }
                //NotificationCenter.default.post(name: Notification.Name(rawValue: "resultsFound"), object: nil)
        })
    }
}

