//
//  File.swift
//  
//
//  Created by Apple on 16/02/24.
//

import Foundation

public protocol Request {
   // init(request : RequestProtocol)
    init(baseURl : URL, path: String?)
    
    @discardableResult
    func set(method : HttpMethods) -> Self
    
    @discardableResult
    func set(path : String?) -> Self
    
    @discardableResult
    func set(headers : [String:String]?) -> Self
    
    @discardableResult
    func set(parameters : Parameters) -> Self
    
    func build() throws -> URLRequest
}
