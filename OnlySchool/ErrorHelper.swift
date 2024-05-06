//
//  ErrorHelper.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import Foundation

enum APIError: Error {
    
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        case .jsonConversionFailure:
            return "JSON Conversion Failure"
        }
    }
}

enum DataServieError: Error {
    
    case unknownError
    case pathError
    case dataFailed
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "error_unknownerror"
        case .pathError:
            return "error_patherror"
        case .dataFailed:
            return "error_dataFailed"
        case .serverError:
            return "error_serverError"
        }
    }
}
