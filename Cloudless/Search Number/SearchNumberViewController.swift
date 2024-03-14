//
//  SearchNumberViewController.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/15/23.
//

import UIKit
import Firebase
//import ProgressHUD

class SearchNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTxtLbl: UILabel!
    @IBOutlet weak var searchLbl: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var resultLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(noResultsFound(_:)), name: Notification.Name(rawValue: "noResultsFound"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI() {
        setUpBackground()
        setUpTitleTextLbl()
        setUpSearchLbl()
        setUpSearchTextField()
        setUpSearchBtn()
        setUpResultLbl()
    }
    
    @IBAction func searchBtnDidTap(_ sender: Any) {
        validateFields()
    }

    @objc func noResultsFound(_ notification: Notification) {
        print("User doesn't exist")
        let alert = UIAlertController(title: "All Clear", message: "No relationships are registed with this number", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateFields() {
        guard let search = self.searchTextField.text, !search.isEmpty else {
            //ProgressHUD.showError(ERROR_EMPTY_SEARCH)
            return
        }
        let characterCount = self.searchTextField.text?.count
        if characterCount != 14 {
            //ProgressHUD.showError(ERROR_INVALID_NUMBER)
            return
        }
        searchRecords()
    }
    
    func searchRecords() {
        let submittedNumberSearch = searchTextField.text

        Api.SubmittedNumber.loadSearchRecord(submittedNumber: submittedNumberSearch!) { (submittedNumber) in
            
            self.resultLbl.isHidden = false
            print("The number: \(submittedNumber.sumbittedNumber)")
            print("Their status: \(submittedNumber.relationShipStatus)")
            
            self.resultLbl.text = "We found a record for \(submittedNumber.sumbittedNumber) and someone else claims they are \(submittedNumber.relationShipStatus)"
        }
    }
}


