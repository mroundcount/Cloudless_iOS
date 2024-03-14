//
//  SubmitNumberViewController+UI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/14/23.
//

import UIKit

extension SubmitNumberViewController {
    
    func setUpBackground() {
        self.view.backgroundColor = UIColor.black
        self.statusTable.backgroundColor = UIColor.clear
    }
    
    func setUpTitleTextLbl() {
        let title = "Submit a Number"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Arial Hebrew", size: 35)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        titleTxtLbl.attributedText = attributedText
        titleTxtLbl.textAlignment = .center
    }
    
    func setUpPhoneNumberLbl() {
        let title = "Enter a phone number and relationship status"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Arial Hebrew", size: 18)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        phoneNumberLbl.attributedText = attributedText
        phoneNumberLbl.textAlignment = .center
    }
    
    
    func setUpPhoneNumberTextField() {
        phoneNumberTextField.layer.borderWidth = 2
        phoneNumberTextField.layer.borderColor = UIColor.blue.cgColor
        phoneNumberTextField.layer.cornerRadius = 27.5
        phoneNumberTextField.clipsToBounds = true
        phoneNumberTextField.backgroundColor = UIColor.clear
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.textColor = UIColor.white
        
        let placeholderAttr = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        phoneNumberTextField.attributedPlaceholder = placeholderAttr
    }
    
    func setUpPhoneNumberWithRecordTextField() {
        phoneNumberTextField.layer.borderWidth = 2
        phoneNumberTextField.layer.borderColor = UIColor.blue.cgColor
        phoneNumberTextField.layer.cornerRadius = 27.5
        phoneNumberTextField.clipsToBounds = true
        phoneNumberTextField.backgroundColor = UIColor.clear
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.textColor = UIColor.white
        Api.SubmittedNumber.loadMyRecords(userID: Api.User.currentUserId) { (returnedPhoneRecord) in
            self.phoneNumberTextField.text = returnedPhoneRecord.sumbittedNumber
        }
    }
    
    func setUpSubmitBtn() {
        submitBtn.setTitle("Submit", for: UIControl.State.normal)
        submitBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        submitBtn.backgroundColor = UIColor.white
        submitBtn.layer.cornerRadius = 27.5
        submitBtn.clipsToBounds = true
        submitBtn.setTitleColor(.white, for: UIControl.State.normal)
        submitBtn.backgroundColor = UIColor.blue
    }
    
    func setUpUpdateBtn() {
        submitBtn.setTitle("Update", for: UIControl.State.normal)
        submitBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        submitBtn.backgroundColor = UIColor.white
        submitBtn.layer.cornerRadius = 27.5
        submitBtn.clipsToBounds = true
        submitBtn.setTitleColor(.white, for: UIControl.State.normal)
        submitBtn.backgroundColor = UIColor.blue
    }

    func setUpDeleteBtn() {
        deleteBtn.setTitle("Delete Record", for: UIControl.State.normal)
        deleteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        deleteBtn.layer.cornerRadius = 27.5
        deleteBtn.layer.borderWidth = 2
        deleteBtn.layer.borderColor = UIColor.blue.cgColor
        deleteBtn.clipsToBounds = true
        deleteBtn.setTitleColor(.white, for: UIControl.State.normal)
        deleteBtn.backgroundColor = UIColor.clear
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = phoneNumberTextField.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        phoneNumberTextField.text = formatter(mask: "(XXX) XXX-XXXX", phoneNumber: newString)
        return false
    }
    
    func formatter(mask:String, phoneNumber:String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result:String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X"{
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
}

