//
//  NetworkLayerTest.swift
//  MovieTMDBTests
//
//  Created by Manar on 6/7/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import XCTest
@testable import MovieTMDB
class NetworkLayerTest: XCTestCase  {


    var url = Constants.LATEST_URL
    func testNetworkService() throws {
        //given
        let networkInstance = NetworkService(httpHandler: HttpHandler())
        let expectation = self.expectation(description: "Test Hitting Network")
        let errorHandler : (Error) -> () = {
            error in
            XCTFail()
        }
        
        let completionHandler :(LatestMoviesResponse) -> () = {
            pageMovies in
            let expectedMoviesNumber = 20
            XCTAssert(pageMovies.movies.count == expectedMoviesNumber)
            expectation.fulfill()
        }
        //when
        networkInstance.getLatestMovies(withPage: 1, completionHandler: completionHandler, errorHandler: errorHandler)
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testMockHttpLayer() throws {
        //given
        let networkInstance = NetworkMocking()
        let expectation = self.expectation(description: "Mock Network")
        let networkCompletionHandler = { (data:Data) -> Void in
            let movieArray : LatestMoviesResponse = JsonMapper<LatestMoviesResponse>().parseObject(jsonData: data)!
            XCTAssertNotNil(movieArray)
            expectation.fulfill()
        }
        let errorHandler : (Error) -> () = { error in
            print(error)
            XCTFail()
        }
        
        networkInstance.getRequest(url: &url, completionHandler: networkCompletionHandler, errorHandler: errorHandler, parameters: ["":""])
        //then
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMockNetworkFails() throws {
        //given
        let networkInstance = NetworkMocking(shouldReturnError: true)
        let completionHandler = { (data:Data) -> Void
            in
            let movieArray = JsonMapper<LatestMoviesResponse>().parseObject(jsonData:data)!
            XCTAssertNil(movieArray)
        }
        let errorHandler = {
            (error:Error) -> Void in
            print(error)
            let err = error
            XCTAssertNotNil(err)
        }
        networkInstance.getRequest(url: &url, completionHandler: completionHandler, errorHandler: errorHandler, parameters: ["":""])
    }
}
