//
//  FeedViewModelProtocol.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import Foundation

protocol FeedViewModelProtocol: AnyObject {
    
    var photos: [Photo] { get }
    func numberOfItems() -> Int
    func getFeed(completion: @escaping() -> Void)
    func searchPhotos(searchQuery: String, completion: @escaping() -> Void)
    
}
