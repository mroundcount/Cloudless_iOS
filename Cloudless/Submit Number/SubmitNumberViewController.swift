//
//  SubmitNumberViewController.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/14/23.
//

import UIKit
import Firebase
//import ProgressHUD

class SubmitNumberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titleTxtLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var statusTable: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    let status = ["Dating", "Friend With Benefits", "In Relationship", "Married"]
    var recordStatus: Int = 0
    var submitStatus: String = ""
    var recordID: String = ""
    var validationPass: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.delegate = self
        statusTable.delegate = self
        statusTable.dataSource = self
        observeData()
        checkForRecord()
        
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(setUpNoRecord(_:)), name: Notification.Name(rawValue: "setUpNoRecord"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setUpUpdateRecord(_:)), name: Notification.Name(rawValue: "setUpUpdateRecord"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func checkForRecord() {
        Api.SubmittedNumber.lookForMyRecords(userID: Api.User.currentUserId)
    }
    
    func setupUI() {
        setUpBackground()
        setUpTitleTextLbl()
        setUpPhoneNumberLbl()
    }
    
    @objc func setUpNoRecord(_ notification: Notification) {
        setUpSubmitBtn()
        setUpPhoneNumberTextField()
        deleteBtn.isHidden = true
    }
    
    @objc func setUpUpdateRecord(_ notification: Notification) {
        recordStatus = 1
        setUpUpdateBtn()
        setUpDeleteBtn()
        observeData()
        setUpPhoneNumberWithRecordTextField()
    }
    

    func observeData() {
        Api.SubmittedNumber.loadMyRecords(userID: Api.User.currentUserId) { (returnedPhoneRecord) in
            self.recordID = returnedPhoneRecord.id
            //setting an initial staus for a checkmark
            self.submitStatus = returnedPhoneRecord.relationShipStatus
        }
    }
    
    @IBAction func submitBtnDidTap(_ sender: Any) {
        validateFields()
        if validationPass == 0 {
            print("validation failed")
            return
        } else {
            print("validation success")
            if recordStatus == 0 {
                sendToFirebase()
            } else {
                sendUpdateToFirebase()
            }
        }
    }
    
    @IBAction func deleteBtnDidTap(_ sender: Any) {
        let usernameRef =  Database.database().reference().child("submittedNumbers/\(self.recordID)");
        print("Deleting: \(usernameRef)")
        usernameRef.removeValue();
        
        let alert = UIAlertController(title: "Record Deleted", message: "Your record has been deleted from our database", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToSearch()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func sendToFirebase() {
        let date: Double = Date().timeIntervalSince1970
        var value = Dictionary<String, Any>()

        value["submitterID"] = Api.User.currentUserId
        value["relationShipStatus"] = submitStatus
        value["sumbittedNumber"] = phoneNumberTextField.text
        value["date"] = date
            
        Api.SubmittedNumber.uploadPhoneRecord(value: value)
        
        let alert = UIAlertController(title: "Submitted", message: "Your record has been submitted to our database. You make continue to make updates to it is need be", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToSearch()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendUpdateToFirebase() {
        print("Update record")
        let date: Double = Date().timeIntervalSince1970
        Database.database().reference().root.child("submittedNumbers").child(recordID).updateChildValues(["relationShipStatus" : submitStatus])
        Database.database().reference().root.child("submittedNumbers").child(recordID).updateChildValues(["sumbittedNumber" : phoneNumberTextField.text])
        Database.database().reference().root.child("submittedNumbers").child(recordID).updateChildValues(["date" : date])
        
        let alert = UIAlertController(title: "Record Updated", message: "Your updates have been submitted to our database", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToSearch()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToSearch() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.configureInitialViewController()
        }
    }
    
    func validateFields() {
        guard let search = self.phoneNumberTextField.text, !search.isEmpty else {
            //ProgressHUD.showError(ERROR_EMPTY_SEARCH)
            validationPass = 0
            print("Validationed failed in empty number")
            return
        }
        let characterCount = self.phoneNumberTextField.text?.count
        if characterCount != 14 {
            //ProgressHUD.showError(ERROR_INVALID_NUMBER)
            validationPass = 0
            print("Validationed failed in formatting")
            return
        }
        
        if submitStatus == "" {
            //ProgressHUD.showError(ERROR_INVALID_RELATIONSHIP_STATUS)
            validationPass = 0
            print("Validationed failed in status")
            return
        }
        validationPass = 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath)
        cell.textLabel?.text = status[indexPath.row]
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        
        
        Api.SubmittedNumber.loadMyRecords(userID: Api.User.currentUserId) { (returnedPhoneRecord) in
            if cell.textLabel?.text == "Dating" && returnedPhoneRecord.relationShipStatus == "Dating" {
                cell.accessoryType = .checkmark
                //self.submitStatus = "Dating"
            }
            if cell.textLabel?.text == "Friend With Benefits" && returnedPhoneRecord.relationShipStatus == "Friend With Benefits" {
                cell.accessoryType = .checkmark
                //self.submitStatus = "Friend With Benefits"
            }
            if cell.textLabel?.text == "In Relationship" && returnedPhoneRecord.relationShipStatus == "In Relationship" {
                cell.accessoryType = .checkmark
                //self.submitStatus = "In Relationship"
            }
            if cell.textLabel?.text == "Married" && returnedPhoneRecord.relationShipStatus == "Married" {
                cell.accessoryType = .checkmark
                //self.submitStatus = "Married"
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            print("New status: \(self.submitStatus)")
            if cell.textLabel?.text == "Dating" && self.submitStatus != "Dating" {
                cell.accessoryType = .none
            }
            if cell.textLabel?.text == "Friend With Benefits" && self.submitStatus != "Friend With Benefits" {
                cell.accessoryType = .none
            }
            if cell.textLabel?.text == "In Relationship" && self.submitStatus != "In Relationship" {
                cell.accessoryType = .none
            }
            if cell.textLabel?.text == "Married" && self.submitStatus != "Married" {
                cell.accessoryType = .none
            }
        }
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        submitStatus = status[indexPath.row]
        print("Your status is: \(submitStatus)")
        
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
