//
//  Photo.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import Foundation

struct Results: Codable {
    let results: [Photo]
}

struct Photo: Codable {
    let id: String
    let created_at: String
    let urls: Urls
    let user: User
    let downloads: Int?
}

struct Urls: Codable {
    let raw, full, regular, small, thumb: String
}

struct User: Codable {
    let name: String
    let location: String?
}
