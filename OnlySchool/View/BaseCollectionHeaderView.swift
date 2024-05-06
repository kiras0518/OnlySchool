//
//  BaseCollectionHeaderView.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/28.
//

import Foundation
import UIKit

enum CellType: Int {
    case bigCell
    case smallCell
}

class HeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "SectionHeaderView"
    
    lazy var titleLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .black
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLb)
    
        titleLb.translatesAutoresizingMaskIntoConstraints = false
        titleLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

