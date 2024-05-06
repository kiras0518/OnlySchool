//
//  DataLoaderManager.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import UIKit

class DataLoaderManager: DataLoaderProtocol {
    
    private let fileName: String = ""
    
    func loadData<T>(fileName: String, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        
        guard let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
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
    
    // 使用 async 寫法
    func loadDataAsync<T>(fileName: String) async throws -> T where T : Decodable {
        
        guard let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw APIError.invalidData
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decoderes = try JSONDecoder().decode(T.self, from: data)
            return decoderes
        } catch {
            throw APIError.jsonParsingFailure
        }
    }
    
}
