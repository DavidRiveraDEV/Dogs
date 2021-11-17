//
//  StoredDog.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation
import RealmSwift

class StoredDog: Object {
    
    @objc dynamic var dogName: String?
    @objc dynamic var dogDescription: String?
    @objc dynamic var age: Int = 0
    @objc dynamic var image: String?
}
