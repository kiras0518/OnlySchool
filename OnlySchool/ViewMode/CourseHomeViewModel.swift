//
//  CourseHomeViewModel.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import UIKit

// 定義委派協定，用於資料更新
protocol CourseViewModelDelegate: AnyObject {
    func didUpdata(_ rootData: RootModel)
    func didFailWithError(_ error: DataServieError)
}

// Injection
class CourseHomeViewModel {
    
    let dataLoader: DataLoaderProtocol
    
    init(courseLoader: DataLoaderProtocol) {
        self.dataLoader = courseLoader
    }
    
    weak var delegate: CourseViewModelDelegate?
    
    func loadCourses() {
        dataLoader.loadData(fileName: "data") { (res: Result<RootModel, DataServieError>) in
            switch res {
            case .success(let rootData):
                self.delegate?.didUpdata(rootData)
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            }
        }
    }
}
