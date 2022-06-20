//
//  FavouritesViewModelProtocol.swift
//  Test_task
//
//  Created by max on 20.06.2022.
//

import Foundation

protocol FavouritesViewModelProtocol: AnyObject {
    
    var photos: [LikedPhoto] { get set }
    func retrievePhoto(completion: @escaping () -> Void)
    func deletePhoto(photo: LikedPhoto)
    func getPhotoURL(at indexPath: IndexPath) -> String
    func getAuthorName(at indexPath: IndexPath) -> String
    func numberOfRows() -> Int
}
