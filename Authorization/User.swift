//
//  User.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/21/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

struct User: Mappable {
    var token = ""
    var id = 0
    var email = ""
    var imageUrl = ""
    var fullName = ""

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        token <- map["token"]
        id <- map["user.id"]
        email <- map["user.email"]
        fullName <- map["user.full_name"]
        imageUrl <- map["user.avatar"]
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: testStr)
    }
    
    static func showAlert(_ title: String, _ message: String, _ actionTitle: String) -> UIAlertController {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alertView.addAction(action)
        return alertView
    }
    
    static func authorize(email: String,
                          password: String,
                          completion: @escaping (User?, String?) -> Void) {
        let parametres = [
            "username" : email,
            "password" : password
        ]
        let url = "https://apivotem.solf.io/api/authe/login/"
        Alamofire.request(url, method: .post, parameters: parametres).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    completion(User(JSON: json)!, nil)
                case 6:
                    completion(nil, "email not found in server")
                default:
                    completion(nil, "error")
                }
            case .failure(let value):
                completion(nil, value.localizedDescription)
            }
        }
    }
}
