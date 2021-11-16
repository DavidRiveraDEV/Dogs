//
//  LoggerProtocol.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

public protocol LoggerProtocol {
    
    func v(_ messages: Any...)
    
    func d(_ messages: Any...)
    
    func i(_ messages: Any...)
    
    func w(_ messages: Any...)
    
    func e(_ messages: Any...)
    
}
