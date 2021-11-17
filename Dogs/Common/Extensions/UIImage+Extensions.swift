//
//  UIImage+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 14/11/21.
//

import UIKit
import Kingfisher

extension UIImage {
    
    static func download(url: URL, id: String?, completion: ((_ image: UIImage?, _ id: String?) -> Void)? = nil) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    completion?(image, id)
                    return
                }
            }
            completion?(nil, id)
        }
    }
}
