//
//  ResponseProtocol.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

public protocol Response {
    var statusCode: StatusCode { get }
}
