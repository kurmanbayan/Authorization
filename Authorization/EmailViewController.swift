//
//  EmailViewController.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/21/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Foundation

private struct Constants{
    static let passwordSegue = "Show Password"
}

class EmailViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var secondView: UIView!

    @IBAction private func textBegin(_ sender: UITextField) {
        secondView.backgroundColor = UIColor.orange
    }
    
    @IBAction private func textEnd(_ sender: UITextField) {
        secondView.backgroundColor = UIColor.gray
    }
    
    @IBAction private func showPassword(_ sender: UIBarButtonItem) {
        let email = emailTextField.text!
        if User.isValidEmail(testStr: email) {
            view.endEditing(true)
            performSegue(withIdentifier: Constants.passwordSegue, sender: email)
        }
        else {
            self.present(User.showAlert("Try again", "Wrong email format", "Ок"),
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction private func editingChanged(_ sender: UITextField) {
        if (emailTextField.text?.isEmpty)! {
            self.navigationItem.rightBarButtonItem = nil
        }
        else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Далее", style: .plain, target: self, action: #selector(showPassword))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.passwordSegue:
            let destinationVC = segue.destination as! PasswordViewController
            destinationVC.email = sender as! String
        default: break;
        }
    }
}
