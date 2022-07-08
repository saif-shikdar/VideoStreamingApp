//
//  MockNetworkManager.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation
@testable import VideoStreamingApp

class MockNetworkManager: Networkable {
    var mockResponseName = ""
    func get(apiRequest: ApiRequestType) async throws -> Data {
        
        let bundle = Bundle(for:MockNetworkManager.self)
        
        guard let url = bundle.url(forResource: mockResponseName, withExtension:"json"),
              let data = try? Data(contentsOf: url) else {
            throw APIError.invalidData
        }
        return data
    }
    
}
