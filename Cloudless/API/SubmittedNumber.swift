//
//  SubmittedNumber.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/17/23.
//

import Foundation

// dictionary
class SubmittedNumber {
    var id: String
    var submitterID: String
    var sumbittedNumber: String
    var relationShipStatus: String
    var date: Double

    //initializing the variables
    init(id: String, submitterID: String, sumbittedNumber: String, relationShipStatus: String, date: Double) {
        self.id = id
        self.submitterID = submitterID
        self.sumbittedNumber = sumbittedNumber
        self.relationShipStatus = relationShipStatus
        self.date = date

    }
    
    //passing in the variables to be published
    static func transformSubmittedNumber(dict: [String: Any], keyId: String) -> SubmittedNumber? {
        guard let submitterID = dict["submitterID"] as? String,
            let date = dict["date"] as? Double else
            {
                return nil
            }
            let sumbittedNumber = (dict["sumbittedNumber"] as? String) == nil ? "" : (dict["sumbittedNumber"]! as! String)
            let relationShipStatus = (dict["relationShipStatus"] as? String) == nil ? "" : (dict["relationShipStatus"]! as! String)
                   
    let submittedNumber = SubmittedNumber(id: keyId, submitterID: submitterID, sumbittedNumber: sumbittedNumber, relationShipStatus: relationShipStatus, date: date)
        return submittedNumber
    }

}
