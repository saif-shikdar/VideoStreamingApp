//
//  MockSearchUseCase.swift
//  PhotoSearchTests
//
//  Created by Saif on 07/07/22
//

import Foundation
@testable import VideoStreamingApp

class MokcSearchUseCase: SearchUseCase {
    
    var resonseType: String = ""
    
    func execute() async throws -> [VideoRecord] {
        
        if resonseType == "Invalid_search_response" {
            throw APIError.invalidSearch
        }
        else  if resonseType == "invalid_navigation_url" {
           return [VideoRecord(id:"1", name:"myName", location:"London", videoUrl:nil)]
        }
        
        
        return [VideoRecord(id:"1", name:"myName", location:"London", videoUrl: URL(string: "test")!)]
    }
}
