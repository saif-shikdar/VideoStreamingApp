//
//  SearchRepository.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation

protocol SearchRepository {
    func getVideos() async throws -> [VideoRecord]
}
