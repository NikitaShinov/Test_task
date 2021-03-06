//
//  NetworkManager.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - get random photos for main collection
    func getRandomImages(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: Constants.baseUrl.rawValue + Constants.getRandomPhoto.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(Constants.accessKey.rawValue)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    //MARK: - search for photos
    func searchPhoto(searchQuery: String, completion: @escaping(Results?) -> Void) {
        guard let url = URL(string: Constants.baseUrl.rawValue + Constants.searchPhoto.rawValue + searchQuery) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(Constants.accessKey.rawValue)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let searchResults = try JSONDecoder().decode(Results.self, from: data)
                completion(searchResults)
            } catch {
                print (error)
            }

        }.resume()
    }
}
