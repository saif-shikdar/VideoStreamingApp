//
//  SearchRepositoryTests.swift
//  PhotoSearchTests
//
//  Created by Saif on 07/07/22
//

import XCTest
@testable import VideoStreamingApp

class SearchRepositoryTests: XCTestCase {

    var searchRespository: SearchRepository!
    let networkManager = MockNetworkManager()

    override func setUp() {
        searchRespository = DefaultSearchRepository(networkManager: networkManager)
    }
    
    // Valid Response
    func testGetVideos_success() async{
    
        networkManager.mockResponseName = "valid_search_response"
        let vidoeRecords =  try? await searchRespository.getVideos()
        
        XCTAssertEqual(vidoeRecords?.count, 4)

        XCTAssertEqual(vidoeRecords!.first!.name, "myName")

        XCTAssertEqual(vidoeRecords!.first!.location, "London")

    }
    
    // InValid Response : Json Parsing Failed
    func testGetVideos_failure() async{
        networkManager.mockResponseName = "invalid_search_response"
        do  {
           let _ =  try await searchRespository.getVideos()
        }catch {
            XCTAssertEqual(error as! APIError, APIError.jsonParsingFailed)
        }
        
    }
    
    // Empty Response : Json Parsing Failed
    func testGetVideos_emptyResponse() async{
        networkManager.mockResponseName = "empty_search_response"
        do  {
          let _ =  try await searchRespository.getVideos()
        }catch {
            XCTAssertEqual(error as! APIError, APIError.emptyRecords)
        }
        
    }
    
    // invalid URL
    func testGetVideos_invalidURL() async{
        networkManager.mockResponseName = "invalid_url"
        do  {
          let _ =  try await searchRespository.getVideos()
        }catch {
            XCTAssertEqual(error as! APIError, APIError.invalidData)
        }
        
    }
    
//    // Cached Response
//    func testGetImages_fromCachedResponse() async{
//    
//        // GIVEN
//       let _ =  try? await searchRespository.getImages(for:"valid_keyword_search_response")
//        
//        // When
//        
//        let photoRecords =  try? await searchRespository.getImages(for:"valid_keyword_search_response")
//        
//        XCTAssertEqual(photoRecords?.count, 20)
//
//        XCTAssertEqual(photoRecords!.first!.previewURL, "https://cdn.pixabay.com/photo/2017/06/20/22/14/man-2425121_150.jpg")
//        
//    }
//    
//    
//    // Empty Response
//    func testGetImages_ForEmptyResonse() async{
//        
//        do  {
//            _ =  try await searchRespository.getImages(for:"empty_search_response")
//            
//        }catch {
//            XCTAssertEqual(error as! APIError, APIError.emptyRecords)
//        }
//        
//    }
//    
//    // InValid Response
//    func testGetImages_ForInvalidResonse() async{
//        
//        do  {
//            _ =  try await searchRespository.getImages(for:"invalid_search_response")
//            
//        }catch {
//            XCTAssertEqual(error as! APIError, APIError.jsonParsingFailed)
//        }
//        
//    }
    
    
}
