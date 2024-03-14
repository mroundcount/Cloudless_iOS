//
//  HomeViewController.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/13/23.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var termsOfServiceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        setBackgroundImg()
        setUpHeaderTitle()
        setUpOrLabel()
        setUpSignInBtn()
        setUpCreateAccountBtn()
        setUpTermsLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func signInBtnDidTap(_ sender: Any) {
        print("Sign In Tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signIn = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_SIGN_IN) as! SignInViewController
        self.navigationController?.pushViewController(signIn, animated: true)
         
    }
    @IBAction func createAccountBtnDidTap(_ sender: Any) {
        print("Create Account Tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_SIGN_UP) as! SignUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
         
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print("Terms Label Tapped")
        /*
        if let url = NSURL(string: "https://hookedmusic.app/legal/Terms.pdf") {
            UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
        }
         */
    }
}

