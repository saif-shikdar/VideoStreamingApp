//
//  SearchUseCase.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation

protocol SearchUseCase {
    func execute() async throws -> [VideoRecord]
}

final class DefaultSearchUseCase: SearchUseCase {
    private var searchRepository: SearchRepository

    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func execute() async throws -> [VideoRecord] {
        do {
            return try await searchRepository.getVideos()        }catch {
          throw error
        }
    }
}
