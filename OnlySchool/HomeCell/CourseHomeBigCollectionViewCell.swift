//
//  CourseHomeBigCollectionViewCell.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import UIKit

class CourseHomeBigCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "CourseHomeBigCell"
    
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
        imageView.layer.cornerRadius = 8 //15
        
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
