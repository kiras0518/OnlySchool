//
//  DataLoader.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/15.
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

// 抽象讀取資料，若有 API 或其他讀取資料方式，可以在此擴充
protocol DataLoaderProtocol {
    func loadData<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void)
}

class DataLoaderManager: DataLoaderProtocol {
    
    static let shared = DataLoaderManager()
    
    private init() {}
    
    func loadData<T>(completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        guard let path = Bundle.main.url(forResource: "data", withExtension: "json") else {
            completion(.failure(.invalidData))
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decoderes = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decoderes))
        } catch {
            completion(.failure(.jsonParsingFailure))
        }
    }
}
