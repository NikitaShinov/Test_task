//
//  DetailsViewController.swift
//  Test_task
//
//  Created by max on 20.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photoURL: String?
    var downloads: String?
    var author: String?
    var location: String?
    var creationDate: String?
    
    init(photoURL: String, downloads: String, author: String, location: String, creationDate: String) {
        super.init(nibName: nil, bundle: nil)
        self.photoURL = photoURL
        self.downloads = downloads
        self.author = author
        self.location = location
        self.creationDate = creationDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    // MARK: - Private Methods
    
    private func configureUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(selectedImage)
        view.addSubview(authorName)
        view.addSubview(likeButton)
        view.addSubview(picLocation)
        view.addSubview(picDownloads)
        view.addSubview(createdAt)
        likeButton.addTarget(self, action: #selector(addToFavourites), for: .touchUpInside)
        setupLikeButton()
        
    }
    
    @objc private func addToFavourites() {
        
        guard let downloads = downloads else {
            return
        }
    
        if StorageManager.shared.searchInCoreData(with: photoURL) {
            guard let searchedObject = StorageManager.shared.retrieveSingleObject(with: photoURL) else { return }
            StorageManager.shared.delete(photo: searchedObject)
            likeButton.setTitle("Добавить в избранное", for: .normal)
            likeButton.backgroundColor = .systemBlue
            presentAlert(title: nil, message: "Фото удалено из избранных")
        } else {
            StorageManager.shared.save(author: author,
                                       photoUrl: photoURL,
                                       downloads: downloads,
                                       location: location,
                                       creationDate: creationDate)
            likeButton.setTitle("Удалить из избранных", for: .normal)
            likeButton.backgroundColor = .systemRed
            presentAlert(title: nil, message: "Фото добавлено в избранные")
        }
    }
    
    private func setupUI() {

        selectedImage.kf.setImage(with: URL(string: photoURL ?? ""))
        authorName.text = author
        picLocation.text = "Локация: \(location ?? "Нет данных")"
        picDownloads.text = "Загрузок: \(downloads ?? "Нет загрузок")"
        let date = DateConverter.shared.setupDate(date: creationDate ?? "" )
        createdAt.text = "Дата создания - \(date)"
        
    }
    
    private func setupLikeButton() {
        if StorageManager.shared.searchInCoreData(with: photoURL) {
            likeButton.setTitle("Удалить из избранных", for: .normal)
            likeButton.backgroundColor = .systemRed
        } else {
            likeButton.setTitle("Добавить в избранное", for: .normal)
            likeButton.backgroundColor = .systemBlue
        }
    }
    
    private func setupLayout() {
        selectedImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: view.frame.size.height / 3)
        
        authorName.anchor(top: selectedImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 30)
        
        picLocation.anchor(top: authorName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width / 2, height: 40)
        
        picDownloads.anchor(top: authorName.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: view.frame.size.width / 2, height: 40)
        
        createdAt.anchor(top: picDownloads.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 20)
        
        likeButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 70, paddingRight: 50, width: 0, height: 50)
    }
    
}
