//
//  FavouritesTableViewCell.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    
    static let indentifier = "favouritesCell"
    
    lazy var picture: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var authorName: UILabel = {
        let name = UILabel()
        name.font = .boldSystemFont(ofSize: 15)
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(picture)
        contentView.addSubview(authorName)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemPurple.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        picture.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        authorName.anchor(top: topAnchor, left: picture.rightAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: contentView.frame.size.width / 2, height: 20)
        
    }
}


