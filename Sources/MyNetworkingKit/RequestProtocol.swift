//
//  File.swift
//  
//
//  Created by Apple on 16/02/24.
//

import Foundation

public protocol RequestProtocol {
    var baseUrl : URL { get }
    var path    : String? { get }
    var method  : HttpMethods { get }
    var headers : [String:String]? { get }
    var parameters : Parameters { get }
}
