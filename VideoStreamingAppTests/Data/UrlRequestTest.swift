//
//  UrlRequestTest.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import XCTest
@testable import VideoStreamingApp

class UrlRequestTest: XCTestCase {
    
    // rigth URL
    func testRequest_whenUrlIsCorrect() {
        
        // GIVEN
        let apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path:"", params:["q":"test"])
        // When
        let requeast = URLRequest.getURLRequest(for: apiRequest)
        // Then
        
        XCTAssertEqual(requeast!.url!.absoluteString, "https://jsonkeeper.com/b/3AB2?q=test")
    }
    
    // wrong URL
    func testRequest_whenUrlIsInCorrect() {
        
        // GIVEN
        let apiRequest = ApiRequest(baseUrl: "", path:"", params:["q":"test"])
        // When
        let requeast = URLRequest.getURLRequest(for: apiRequest)
        // Then
        
        XCTAssertNil(requeast?.url)
    }
}
