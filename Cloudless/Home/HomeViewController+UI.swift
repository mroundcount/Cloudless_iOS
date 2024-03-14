//
//  HomeViewController+UI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/13/23.
//

import UIKit
import Foundation

extension HomeViewController {
    
    func setBackgroundImg() {
        let randomInt = Int.random(in: 1..<4)
        print("Background Img: \(randomInt)")
        if randomInt == 1 {
            backgroundImg.image=UIImage(named: "background_landing1")
        } else if randomInt == 2 {
            backgroundImg.image=UIImage(named: "background_landing1")
        } else if randomInt == 3 {
            backgroundImg.image=UIImage(named: "background_landing1")
        }
        
        //Adjusting the image
        let coverLayer = CALayer()
        coverLayer.frame = backgroundImg.bounds;
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.55
        backgroundImg.layer.addSublayer(coverLayer)
    }
    
    func setUpHeaderTitle() {
        welcomeLbl.text = "Cloudless"
        welcomeLbl.textColor = UIColor.white
        welcomeLbl.font = UIFont.boldSystemFont(ofSize: 25.0)
    }
    
    func setUpOrLabel() {
        orLbl.text = "OR"
        orLbl.textColor = UIColor.white
        orLbl.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    func setUpSignInBtn() {
        signInBtn.setTitle("Sign in with email", for: UIControl.State.normal)
        signInBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signInBtn.setTitleColor(UIColor.white, for: .normal)
        signInBtn.backgroundColor = UIColor.clear
        signInBtn.layer.borderWidth = 2
        signInBtn.layer.borderColor = UIColor.blue.cgColor
        signInBtn.layer.cornerRadius = 27.5
        signInBtn.clipsToBounds = true
    }
    
    func setUpCreateAccountBtn() {
        createAccountBtn.setTitle("Create a new account", for: UIControl.State.normal)
        createAccountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        createAccountBtn.setTitleColor(UIColor.white, for: .normal)
        createAccountBtn.backgroundColor = UIColor.blue
        createAccountBtn.layer.cornerRadius = 27.5
        createAccountBtn.clipsToBounds = true
    }
    
    func setUpTermsLabel() {
        let attributedTermsText = NSMutableAttributedString(string: "By clicking 'Create a new account' you agree to our ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.white])
        
        let attributedTermsSubTitle = NSMutableAttributedString(string: "Terms of Service", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.white])
        
        //The combination of the two attributed texts
        attributedTermsText.append(attributedTermsSubTitle)
        
        termsOfServiceLbl.attributedText = attributedTermsText
        termsOfServiceLbl.numberOfLines = 0
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.termsOfServiceLbl.isUserInteractionEnabled = true
        self.termsOfServiceLbl.addGestureRecognizer(labelTap)
        self.termsOfServiceLbl.textAlignment = .center
    }
}
