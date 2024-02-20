//
//  File.swift
//  
//
//  Created by Apple on 16/02/24.
//

import Foundation

public enum APIError : Error {
    case urlError
    case decodingError
    case unkownError(String)
    case customError(String)
}

public enum HTTPError: Error {
    case badRequest          // 400
    case unauthorized        // 401
    case forbidden           // 403
    case notFound            // 404
    case internalServerError // 500
    // Add more cases as needed

    // Customized description for each case
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .internalServerError:
            return "Internal Server Error"
        }
    }

    // Helper function to create an HTTPError based on status code
    static func fromStatusCode(_ statusCode: Int) -> HTTPError? {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500:
            return .internalServerError
        default:
            return nil
        }
    }
}
