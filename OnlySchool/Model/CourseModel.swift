//
//  CourseModel.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/15.
//

import Foundation

struct RootModel : Codable {
    
    let data : [CategoryModel]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CategoryModel].self, forKey: .data)
    }
    
}

struct CategoryModel : Codable {
    let category : String?
    let courses : [CoursesModel]?
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case courses = "courses"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        courses = try values.decodeIfPresent([CoursesModel].self, forKey: .courses)
    }
}

struct CoursesModel : Codable {
    let title : String?
    let coverImageUrl : String?
    let name : String?
    let category : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case coverImageUrl = "coverImageUrl"
        case name = "name"
        case category = "category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        coverImageUrl = try values.decodeIfPresent(String.self, forKey: .coverImageUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        category = try values.decodeIfPresent(String.self, forKey: .category)
    }
    
}


