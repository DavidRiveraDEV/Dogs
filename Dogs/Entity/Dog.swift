//
//  Dog.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

struct Dog: Codable {
    
    var dogName: String?
    var dogDescription: String?
    var age: Int = 0
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        
        case dogName
        case dogDescription = "description"
        case age
        case image
    }
}
