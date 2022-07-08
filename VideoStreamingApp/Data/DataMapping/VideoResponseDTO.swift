//
//  ImagesResponse.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation

// MARK: - VideoResponse
struct VideoResponseDTO: Decodable {
    let id: String
    let name: String
    let location: String
    let videoUrl: String
}

// MARK: - Mappings to Domain

extension VideoResponseDTO {
    func toDomain() -> VideoRecord {
        return VideoRecord(id: id, name: name, location: location, videoUrl: URL(string: videoUrl))
    }
}
