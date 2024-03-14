//
//  ProfileOptionsTableViewController+UI.swift
//  Cloudless
//
//  Created by Michael Roundcount on 10/14/23.
//

import UIKit

extension ProfileOptionsTableViewController {
    
    func setUpBackground() {
        self.view.backgroundColor = UIColor.black
        self.tableView.backgroundColor = UIColor.black
    }
    
    func setUpTitleTextLbl() {
        let title = "Options"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Arial Hebrew", size: 35)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        titleTxtLbl.attributedText = attributedText
        
        titleTxtLbl.textAlignment = .center
    }
        
    func setUpFAQLbl() {
        FAQLbl.text = "FAQs"
        FAQLbl.textColor = UIColor.white
    }
    
    func setUpPrivacyPolicyLbl() {
        privacyPolicyLbl.text = "Privacy Policy"
        privacyPolicyLbl.textColor = UIColor.white
    }
    
    func setUpTermsOfServiceLbl() {
        termsOfServiceLbl.text = "Terms of Service"
        termsOfServiceLbl.textColor = UIColor.white
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        returnedView.backgroundColor = UIColor.black
        
        let firstLabel = UILabel(frame: CGRect(x: 8, y: 15, width: tableView.bounds.size.width, height: 25))
        let subLabel = UILabel(frame: CGRect(x: 8, y: -3, width: tableView.bounds.size.width, height: 25))
        
        if (section == 0) {
            firstLabel.text = "Help"
        } else if (section == 1) {
            subLabel.text = "Terms"
        } else if (section == 2) {
            subLabel.text = "Logout"
        } else if (section == 3) {
            subLabel.text = "Delete Account"
        }
                
        firstLabel.textColor = UIColor.blue
        subLabel.textColor = UIColor.blue
        
        firstLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        subLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        returnedView.addSubview(firstLabel)
        returnedView.addSubview(subLabel)

        return returnedView
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
}
