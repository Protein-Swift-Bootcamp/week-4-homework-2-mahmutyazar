//
//  Music.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 4.01.2023.
//

import Foundation

// MARK: - Music
struct Music: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let title, genreDescription: String?
    let type: TypeEnum?
    let path: String?
    let imageURL: String?
    let imageTitle: String?
    let featuredImage: String?
    let shareURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case genreDescription = "description"
        case type, path
        case imageURL = "imageUrl"
        case imageTitle, featuredImage
        case shareURL = "shareUrl"
    }
}

enum TypeEnum: String, Codable {
    case genre = "genre"
}
