//
//  DataLoader.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/15.
//

import Foundation

// 抽象讀取資料，若有 API 或其他讀取資料方式，可以在此擴充
protocol DataLoaderProtocol {
    func loadData<T: Decodable>(fileName: String, completion: @escaping (Result<T, DataServieError>) -> Void)
}
