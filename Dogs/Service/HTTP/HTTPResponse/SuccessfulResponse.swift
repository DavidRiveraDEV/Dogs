//
//  SuccessfulResponse.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

public struct SuccessfulResponse: Response {
    
    public var statusCode: StatusCode
    public var data: Data?
    
    init(statusCode: StatusCode, data: Data?) {
        self.statusCode = statusCode
        self.data = data
    }
}
