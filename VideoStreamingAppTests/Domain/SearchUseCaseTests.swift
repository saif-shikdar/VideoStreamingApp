//
//  SearchUseCaseTests.swift
//  PhotoSearchTests
//
//  Created by Saif on 07/07/22
//

import XCTest
@testable import VideoStreamingApp

class SearchUseCaseTests: XCTestCase {

    var searchUseCase: SearchUseCase!
    
    override func setUp() {
        searchUseCase = DefaultSearchUseCase(searchRepository: MockSearchRepository())

    }
    
    // Valid Search
    func testVideoSearch() async {
        
        let videoRecords =   try? await searchUseCase.execute()
        
        XCTAssertEqual(videoRecords?.count, 1)
    
    }

}
