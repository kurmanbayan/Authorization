//
//  Storyboard.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/27/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit

private struct Constants {
    static let authorizationNC = "NavigationController"
    static let userInfoVC = "UserInfoVC"
    static let mainStoryboard = "Main"
}

struct Storyboard {
    private static let authorization = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
    
    static var authorizationNC: UINavigationController {
        return authorization.instantiateViewController(withIdentifier: Constants.authorizationNC) as! UINavigationController
    }
    static var tokenInfoVC: UserInfoViewController {
        return authorization.instantiateViewController(withIdentifier: Constants.userInfoVC) as! UserInfoViewController
    }
}
