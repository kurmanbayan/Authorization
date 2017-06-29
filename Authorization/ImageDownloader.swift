//
//  ImageDownloader.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/29/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct ImageDownloader {
    
    static func fetchImage(with url: String,
                           completion: @escaping (UIImage) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
}
