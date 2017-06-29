//
//  Storage.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/27/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import Cache

private struct Caches {
    static let jsonCache = SpecializedCache<JSON>(name: "JSON Cache")
}

private struct Keys {
    static let user = "User"
}

struct Storage {
    
    static var user: User? {
        get {
            if let json = Caches.jsonCache.object(forKey: Keys.user) {
                switch json {
                case .dictionary(let userJSON): return User(JSON: userJSON)!
                default: break
                }
            }
            return nil
        }
        set {
            if let user = newValue {
                try! Caches.jsonCache.addObject(JSON.dictionary(user.toJSON()), forKey: Keys.user)
            } else {
                try! Caches.jsonCache.removeObject(forKey: Keys.user)
            }
        }
    }
    
}
