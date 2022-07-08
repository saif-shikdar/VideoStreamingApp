//
//  SearchViewModelTests.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import XCTest
@testable import VideoStreamingApp

class SearchViewModelTests: XCTestCase {

    var viewModel:SearchViewModel!
    let searchUseCase = MokcSearchUseCase()

    override func setUpWithError() throws {
        viewModel = SearchViewModel(searchUseCase:searchUseCase)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // Valid vidoe search
    func testSearch_video_success() async {
    
        //GIVEN : Valid Search
        searchUseCase.resonseType = "valid_search_response"
        
        // When
        await viewModel.getGalleryVideos()

        // Then
        XCTAssertEqual(viewModel.state, .showVideosList)
        
        XCTAssertEqual(viewModel.videoRecordsCount, 1)

        XCTAssertEqual(viewModel.getVideoDetails(index: 0).location, "London")
    }
    
    // Error
    func testSearch_search_failure() async {
    
        //GIVEN : Valid Search
        searchUseCase.resonseType = "Invalid_search_response"
        
        // When
        await viewModel.getGalleryVideos()

        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.invalidSearch.localizedDescription))
    }
    
    // Navigate Gallery with invalid URl
    func testSearch_navigateURL_withInvalidURl() async {
    
        //GIVEN : Valid Search
        searchUseCase.resonseType = "invalid_navigation_url"
        
        // When
        await viewModel.getGalleryVideos()
        
        viewModel.navigateToGallery(for: 0 )

        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.invalidData.localizedDescription))
    }
    
    // Navigate Gallery with valid URl
    func testSearch_navigateURL_withValidURl() async {
    
        //GIVEN : Valid Search
        searchUseCase.resonseType = "valid_keyword_search_response"
        
        // When
        await viewModel.getGalleryVideos()
        
        viewModel.navigateToGallery(for: 0 )

        // Then
        XCTAssertEqual(viewModel.state, .showVideoGallery(URL(string: "test")!))
    }
}
