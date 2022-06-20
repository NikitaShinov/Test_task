//
//  FavouritesViewModel.swift
//  Test_task
//
//  Created by max on 20.06.2022.
//

import Foundation

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    var photos: [LikedPhoto] = []
    
    func retrievePhoto(completion: @escaping () -> Void) {
        StorageManager.shared.retieveLikedPhotos { likedPhotos in
            self.photos = likedPhotos
            completion()
        }
    }
    
    func deletePhoto(photo: LikedPhoto) {
        StorageManager.shared.delete(photo: photo)
    }
    
    func numberOfRows() -> Int {
        photos.count
    }
    
    func getPhotoURL(at indexPath: IndexPath) -> String {
        photos[indexPath.row].photo ?? ""
    }
    
    func getAuthorName(at indexPath: IndexPath) -> String {
        photos[indexPath.row].author ?? ""
    }
    
}
