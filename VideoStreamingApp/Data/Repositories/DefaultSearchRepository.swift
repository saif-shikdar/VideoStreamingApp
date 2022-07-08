//
//  GalleryRepository.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation

final class DefaultSearchRepository {
    
    private let networkManager: Networkable
    
    init(networkManager:Networkable) {
        self.networkManager = networkManager
    }
        
    private func getDecodedResopnse(from data: Data)-> [VideoResponseDTO]? {
        guard let videoResponseDTO = try? JSONDecoder().decode([VideoResponseDTO].self, from: data) else {
            return nil
        }
        return videoResponseDTO
    }
}

extension DefaultSearchRepository: SearchRepository {
    
    func getVideos() async throws -> [VideoRecord] {
        
        let  apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path:"", params: [:])
        
        guard let data = try? await  self.networkManager.get(apiRequest: apiRequest) else {
            throw APIError.invalidData
        }
        
        guard let videoResponseDTO = getDecodedResopnse(from: data) else {
            throw APIError.jsonParsingFailed
        }
        
        let videoRecords = videoResponseDTO.map{ $0.toDomain() }
        
        if videoRecords.isEmpty {
            throw APIError.emptyRecords
        }
            
        return videoRecords
    }
}
