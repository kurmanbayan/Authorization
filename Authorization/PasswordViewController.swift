//
//  PasswordViewController.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/21/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private struct Constants {
    static let userInfoSegue = "Show User Info"
}

class PasswordViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func textBegin(_ sender: UITextField) {
        secondView.backgroundColor = UIColor.orange
    }
    @IBAction func textEnd(_ sender: UITextField) {
        secondView.backgroundColor = UIColor.gray
    }
    @IBAction func editingChanged(_ sender: UITextField) {
        if (passwordTextField.text?.isEmpty)! {
            self.navigationItem.rightBarButtonItem = nil
        }
        else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Далее", style: .plain, target: self, action: #selector(authorize))
        }
    }
    
    var email: String!

    @IBAction func authorize(_ sender: UIBarButtonItem) {
        let password = passwordTextField.text!
        startAnimating()
        dismissKeyboard()
        User.authorize(email: email, password: password) { user, message in
            self.stopAnimating()
            if let message = message {
                self.present(User.showAlert("Try again", "Wrong email or password", "Ок"),
                        animated: true,
                        completion: nil)
                print(message)
            } else {
                Storage.user = user
                self.performSegue(withIdentifier: Constants.userInfoSegue,
                                  sender: user!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.userInfoSegue:
            let destinationVC = segue.destination as! UserInfoViewController
            destinationVC.user = sender as! User
        default:
            break
        }
    }

}
