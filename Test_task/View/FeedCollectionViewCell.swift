//
//  FeedCollectionViewCell.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "feedCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.purple.cgColor
        contentView.layer.cornerRadius = 5
        
        image.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contentView.frame.size.width, height: contentView.frame.size.width)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
