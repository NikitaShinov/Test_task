//
//  FeedViewModel.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import Foundation

class FeedViewModel: FeedViewModelProtocol {
    
    var photos: [Photo] = []
    
    
    func getFeed(completion: @escaping() -> Void) {
        NetworkManager.shared.getRandomImages { [weak self] results in
            switch results {
            case .success(let receivedPhotos):
                self?.photos = receivedPhotos
            case .failure(let error):
                print (error.localizedDescription)
            }
            completion()
        }
    }
    
    func searchPhotos(searchQuery: String, completion: @escaping () -> Void) {
        NetworkManager.shared.searchPhoto(searchQuery: searchQuery) { [weak self] results in
            guard let searchedPhotos = results?.results else { return }
            self?.photos = searchedPhotos
            completion()
        }
    }
    
    func numberOfItems() -> Int {
        photos.count
    }
    
}
