//
//  CourseHomeSmallCollectionViewCell.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import UIKit

class CourseHomeSmallCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "CourseHomeSmallCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    func setupView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.text = " "
        
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.textColor = .gray
        detailLabel.numberOfLines = 1
        detailLabel.text = " "
    }
}

//static let g_xlFont: UIFont = .systemFont(ofSize: 20)
//static let g_lFont: UIFont = .systemFont(ofSize: 15)
//static let g_mFont: UIFont = .systemFont(ofSize: 13)

//static let g_blackColor: UIColor = .black
//static let g_grayColor: UIColor = .gray
//static let g_backgroundColor: UIColor = .white
//static let g_lightGrayColor: UIColor = .lightGray
