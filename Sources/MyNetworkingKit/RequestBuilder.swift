//
//  File.swift
//  
//
//  Created by Apple on 16/02/24.
//

import Foundation

public final class RequestBuilder : Request {
    
    private var baseUrl    : URL
    private var path       : String?
    private var method     : HttpMethods = .get
    private var headers    : [String:String]?
    private var parameters : Parameters?
    
    public init(baseURl: URL, path: String?) {
        self.baseUrl = baseURl
        self.path = path ?? nil
    }
    
    @discardableResult
    public func set(method: HttpMethods) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    public func set(path: String?) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult
    public func set(headers: [String : String]?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    public func set(parameters: Parameters) -> Self {
        self.parameters = parameters
        return self
    }
    
    @discardableResult
    public func build() throws -> URLRequest {
        var url : URL
        if let path = path{
            if #available(iOS 16.0, *) {
                url = baseUrl.appending(path: path)
            } else {
                url = baseUrl.appendingPathComponent(path)
            }
        }else{
            url = baseUrl
        }
         
        var request = URLRequest(url: url,timeoutInterval: 60)
        request.httpMethod = method.methodType
        request.allHTTPHeaderFields = headers
        setBodyData(request: &request)
        return request
    }
    
    private func setBodyData(request : inout URLRequest ) {
        if let parameters = parameters {
            switch parameters {
            case .body(let bodyParam):
                setupRequestBody(bodyParam, for: &request)
            case .url(let urlParam):
                setupRequestUrlBody(urlParam, for: &request)
                
            }
        }
    }
    
    private func setupRequestBody(_ parameters : [String:Any]?, for request : inout URLRequest) {
        if let parameters = parameters {
            let data = try? JSONSerialization.data(withJSONObject: parameters,options: [])
            request.httpBody = data
        }
    }
    
    private func setupRequestUrlBody(_ parameters : [String:String]?, for request : inout URLRequest) {
        
        if let parameters = parameters,
            let url = request.url,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true){
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            request.url = url
        }
    }
}
