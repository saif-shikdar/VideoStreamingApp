//
//  MockSearchRepository.swift
//  PhotoSearchTests
//
//  Created by Saif on 07/07/22.
//

import Foundation
@testable import VideoStreamingApp

class MockSearchRepository: SearchRepository {
    func getVideos() async throws -> [VideoRecord] {
        return [VideoRecord(id:"1", name:"myName", location:"London", videoUrl: URL(string: "test")!)]
    }
}
