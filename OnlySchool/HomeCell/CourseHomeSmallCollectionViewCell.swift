//
//  CourseHomeSmallCollectionViewCell.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import UIKit
import Kingfisher

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

    func configure(model: CoursesModel?) {
        titleLabel.text = model?.title
        detailLabel.text = model?.name
        let url = URL(string: model?.coverImageUrl ?? "")
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
    
    func setupView() {
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
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
