//
//  HTTPClientUtil.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

class HTTPClientUtil {
    
    public static func normalizeBaseUrl(_ baseUrl: String) -> String {
        var newBaseUrl = baseUrl
        if !newBaseUrl.hasSuffix("/") {
            newBaseUrl += "/"
        }
        return newBaseUrl
    }
    
    public static func normalizePath(_ path: String) -> String {
        if path.hasPrefix("/") {
            return self.normalizePath(String(path.dropFirst()))
        }
        return path
    }
}
