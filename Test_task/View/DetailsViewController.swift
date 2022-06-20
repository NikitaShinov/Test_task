//
//  DetailsViewController.swift
//  Test_task
//
//  Created by max on 20.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo: Photo?
    
    lazy var selectedImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var authorName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var picLocation: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var picDownloads: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var createdAt: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Add to favourites", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
        setupLayout()

    }
    
    private func configureUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(selectedImage)
        view.addSubview(authorName)
        view.addSubview(likeButton)
        view.addSubview(picLocation)
        view.addSubview(picDownloads)
        view.addSubview(createdAt)
        likeButton.addTarget(self, action: #selector(addToFavourites), for: .touchUpInside)
        
    }
    
    @objc private func addToFavourites() {
        
        guard let photo = photo else {
            return
        }
        StorageManager.shared.save(photo: photo)
        likeButton.isHidden = true
        dismiss(animated: true)
        
    }
    
    private func setupUI() {
        guard let photo = photo else { return }
        selectedImage.kf.setImage(with: URL(string: photo.urls.regular))
        authorName.text = photo.user.name
        picLocation.text = "Локация: \(photo.user.location ?? "Локация недоступна")"
        picDownloads.text = "Загрузок: \(photo.downloads ?? 0)"
        let date = DateConverter.shared.setupDate(date: photo.created_at)
        createdAt.text = "Дата создания - \(date)"
    }
    
    private func setupLayout() {
        selectedImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: view.frame.size.height / 3)
        
        authorName.anchor(top: selectedImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 30)
        
        picLocation.anchor(top: authorName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width / 2, height: 40)
        
        picDownloads.anchor(top: authorName.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: view.frame.size.width / 2, height: 40)
        
        createdAt.anchor(top: picDownloads.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 20)
        
        likeButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 50, paddingRight: 50, width: 0, height: 50)
    }
    
}

extension DetailViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
