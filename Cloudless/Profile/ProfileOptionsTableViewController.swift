//
//  ProfileOptionsTableViewController.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/13/23.
//

import UIKit
import Firebase


class ProfileOptionsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTxtLbl: UILabel!
    
    @IBOutlet weak var FAQLbl: UILabel!
    
    @IBOutlet weak var privacyPolicyLbl: UILabel!
    @IBOutlet weak var termsOfServiceLbl: UILabel!
    
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var deleteAccountBtn: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpClickableLables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func setupUI() {
        setUpBackground()
        setUpTitleTextLbl()
        setUpFAQLbl()
        setUpPrivacyPolicyLbl()
        setUpTermsOfServiceLbl()
    }
    
    @IBAction func logOutBtnDidTap(_ sender: Any) {
        print("Log Out Button Tapped")
        Api.User.logOut()
        navigateToHome()
    }
    
    @IBAction func deleteAccountBtnDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "Whoa there cowboy!", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
        
        self.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] action in
            self.deleteMyRecords()
            self.deleteMyAccount()
        }))
    }
    
    func setUpClickableLables() {
        let FAQLblTap = UITapGestureRecognizer(target: self, action: #selector(self.FAQLblTap(_:)))
        self.FAQLbl.isUserInteractionEnabled = true
        self.FAQLbl.addGestureRecognizer(FAQLblTap)
        
        let privacyPolicyLblTap = UITapGestureRecognizer(target: self, action: #selector(self.privacyPolicyLblTap(_:)))
        self.privacyPolicyLbl.isUserInteractionEnabled = true
        self.privacyPolicyLbl.addGestureRecognizer(privacyPolicyLblTap)
        
        let termsOfServiceLblTap = UITapGestureRecognizer(target: self, action: #selector(self.termsOfServiceLblTap(_:)))
        self.termsOfServiceLbl.isUserInteractionEnabled = true
        self.termsOfServiceLbl.addGestureRecognizer(termsOfServiceLblTap)
    }
    
    @objc func FAQLblTap(_ sender: UITapGestureRecognizer) {
        print("FAQ label tapped")
    }
    
    @objc func privacyPolicyLblTap(_ sender: UITapGestureRecognizer) {
        print("Privacy label tapped")
    }
    
    @objc func termsOfServiceLblTap(_ sender: UITapGestureRecognizer) {
        print("Terms of Servie label tapped")
    }

    func deleteMyRecords(){
        Api.SubmittedNumber.loadMyRecords(userID: Api.User.currentUserId) { (returnedPhoneRecord) in
            let usernameRef =  Database.database().reference().child("submittedNumbers/\(returnedPhoneRecord.id)");
            print("Deleting: \(usernameRef)")
            usernameRef.removeValue();
        }
    }
    

    func deleteMyAccount() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            let user = Auth.auth().currentUser
            print("user: \(user)")
            
            //Deleting records from the database
            let usernameRef =  Database.database().reference().child("users/\(Api.User.currentUserId)");
            print("Deleting: \(usernameRef)")
            usernameRef.removeValue();
            
            print("Deleting my authentication")
            //This is the method that actually deletes a user from the authentication side of Firebase
            user?.delete { error in
                if let error = error {
                    print("error in deleting account from authenitcation")
                    print(error)
                } else {
                    print("Account deleted from authenitcation!!")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigateToHome()
            }
        }
    }
    
    func navigateToHome() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.configureInitialViewController()
        }
    }
    
}
