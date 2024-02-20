// The Swift Programming Language
// https://docs.swift.org/swift-book

import Combine
import Foundation

public protocol MyNetworkProtocol {
    func fetchRequest<T:Codable>(with builder : RequestBuilder, type : T.Type) throws -> AnyPublisher<T,APIError>
}

public class MyNetworkManager : MyNetworkProtocol  {
    
    public static let NetworkManger = MyNetworkManager()
    
    public init(){}
    
    public func fetchRequest<T : Codable>(with builder: RequestBuilder, type: T.Type) throws -> AnyPublisher<T, APIError> where T : Codable {
        
        
        do{
            let request = try builder.build()
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return URLSession.shared.dataTaskPublisher(for: request)
                .subscribe(on : DispatchQueue.global(qos: .background))
                .tryMap{ data, response -> Data in
                    try processResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
                    return data
                }
           
                .decode(type: T.self, decoder: decoder)
                .mapError{ error -> APIError in
                    if error is DecodingError {
                        return APIError.decodingError
                    }else if let error = error as? APIError {
                        return error
                    }else{
                        return APIError.unkownError("UnKnown Error")
                    }
                }
                .eraseToAnyPublisher()
        }catch (let error){
            throw APIError.decodingError
        }
    }
    
}

private func processResponse(statusCode: Int) throws {
    guard statusCode == 200 else {
        if let httpError = HTTPError.fromStatusCode(statusCode) {
            throw httpError
        } else {
            throw NSError(domain: "YourDomain", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Unknown HTTP Error"])
        }
    }
}
