//
//  SearchNumberViewController+UI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/15/23.
//

import UIKit

extension SearchNumberViewController {
    
    func setUpBackground() {
        self.view.backgroundColor = UIColor.black
    }
    
    func setUpTitleTextLbl() {
        let title = "Search a Number"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Arial Hebrew", size: 35)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        titleTxtLbl.attributedText = attributedText
        titleTxtLbl.textAlignment = .center
    }
    
    func setUpSearchLbl() {
        let title = "Enter a phone number to search"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Arial Hebrew", size: 18)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        searchLbl.attributedText = attributedText
        searchLbl.textAlignment = .center
    }
    
    
    func setUpSearchTextField() {
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor.blue.cgColor
        searchTextField.layer.cornerRadius = 27.5
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.borderStyle = .none
        searchTextField.textAlignment = .center
        
        let placeholderAttr = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        searchTextField.attributedPlaceholder = placeholderAttr
        searchTextField.textColor = UIColor.white
    }
    
    func setUpSearchBtn() {
        searchBtn.setTitle("Search", for: UIControl.State.normal)
        searchBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        searchBtn.backgroundColor = UIColor.white
        searchBtn.layer.cornerRadius = 27.5
        searchBtn.clipsToBounds = true
        searchBtn.setTitleColor(.white, for: UIControl.State.normal)
        searchBtn.backgroundColor = UIColor.blue
    }
    
    func setUpResultLbl() {
        resultLbl.isHidden = true
        resultLbl.textColor = UIColor.white
        resultLbl.textAlignment = .center
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = searchTextField.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        searchTextField.text = formatter(mask: "(XXX) XXX-XXXX", phoneNumber: newString)
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
