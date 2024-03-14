//
//  ForgotPasswordViewController+UI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/13/23.
//

import UIKit

extension ForgotPasswordViewController {
    
    func setUpBackground() {
        self.view.backgroundColor = UIColor.black
    }
    
    func setUpCloseBtn() {
        closeBtn.setImage(UIImage(named: "close-1"), for: .normal)
        closeBtn.backgroundColor = UIColor.white
        closeBtn.layer.cornerRadius = 15
    }
    
    func setUpTitleTextLbl() {
        let title = "Reset Password"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Arial Hebrew", size: 35)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        titleTextLbl.attributedText = attributedText
        titleTextLbl.textAlignment = .center
    }
    
    func setUpEmailTxt() {
        self.emailContainerView.layer.borderWidth = 2
        self.emailContainerView.layer.borderColor = UIColor.blue.cgColor
        self.emailContainerView.layer.cornerRadius = 27.5
        self.emailContainerView.clipsToBounds = true
        self.emailContainerView.backgroundColor = UIColor.clear
        self.emailTextField.borderStyle = .none
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        self.emailTextField.attributedPlaceholder = placeholderAttr
        self.emailTextField.textColor = UIColor.white
    }
    
    func setUpResetBtn() {
        resetBtn.setTitle("Reset My Password", for: UIControl.State.normal)
        resetBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        resetBtn.setTitleColor(UIColor.black, for: .normal)
        resetBtn.layer.cornerRadius = 27.5
        resetBtn.clipsToBounds = true
        resetBtn.backgroundColor = UIColor.blue
    }
    
    func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        //Setting up the keyboard to dismiss
        emailTextField.returnKeyType = UIReturnKeyType.done
        self.emailTextField.delegate = self
    }
    
    //Moving up the keyboard
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -100 // Move view x points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

    func textFieldShouldReturn(_ emailTextField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Dismissing the keyboard. Looks for the repsonder to the text field to give up the statis.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
