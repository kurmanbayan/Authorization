//
//  TokenViewController.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/21/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class TokenViewController: UIViewController {
    
    
    var user = Storage.user! {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        //tokenLabel?.text = user.toJSONString()
    }
    
    var window: UIWindow?
    
}
