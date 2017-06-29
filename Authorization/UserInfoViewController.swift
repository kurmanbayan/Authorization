//
//  UserInfoViewController.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/27/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import SDWebImage

class UserInfoViewController: UIViewController {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    
    var user = Storage.user! {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        loadImageAsync(url: user.imageUrl)
    }
    
    private func loadImageAsync(url: String) {
        userImageView.sd_setShowActivityIndicatorView(true)
        userImageView.sd_setIndicatorStyle(.gray)
        userImageView.sd_setImage(with: URL(string: user.imageUrl))
    }
    
    private func updateUI() {
        userNameLabel?.text = user.fullName
        userEmailLabel?.text = user.email
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func logOutButton(_ sender: UIButton) {
        Storage.user = nil
        appDelegate.storageCheck()
    }
    
    
}
