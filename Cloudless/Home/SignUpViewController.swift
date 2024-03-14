//
//  SignUpViewController.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/13/23.
//

import UIKit
//import ProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleTextLbl: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpKeyboard()
    }
    
    func setUpUI() {
        setUpCloseBtn()
        setUpBackground()
        setUpTitleTextLbl()
        setUpEmailTxt()
        setUpPasswordTxt()
        setUpSignUpBtn()
        setUpSignInBtn()
    }
    
    @IBAction func closeBtnDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpBtnDidTap(_ sender: Any) {
        self.view.endEditing(true)
        self.validateFields()
        //ProgressHUD.show("Loading...")
        Api.User.createAccount(email: self.emailTextField.text!, password: self.passwordTextField.text!, onSuccess: {
            //ProgressHUD.dismiss()
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                scene.configureInitialViewController()
            }
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    @IBAction func signInBtnDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signIn = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_SIGN_IN) as! SignInViewController
        self.navigationController?.pushViewController(signIn, animated: true)
    }

    func validateFields() {
        guard let email = self.emailTextField.text, !email.isEmpty else {
            //ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            //ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }
}
