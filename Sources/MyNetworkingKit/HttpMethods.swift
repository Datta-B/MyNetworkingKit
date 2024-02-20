//
//  File.swift
//  
//
//  Created by Apple on 16/02/24.
//

import Foundation

public enum HttpMethods : String {
    case get
    case post
    case Put
    case patch
    case delete
    
    public var methodType : String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .Put:
            "PUT"
        case .patch:
            "PATCH"
        case .delete:
            "DELETE"
        }
    }
    
}
