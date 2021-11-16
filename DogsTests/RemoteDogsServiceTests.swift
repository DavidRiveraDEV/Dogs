//
//  RemoteDogsServiceTests.swift
//  DogsTests
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

import XCTest
@testable import Dogs

class RemoteDogsServiceTests: XCTestCase {
    
    private var sut: RemoteDogsService!
    
    override func setUp() {
        super.setUp()
        self.sut = RemoteDogsService()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testGetDogsSuccessful() throws {
        
        let expectation = expectation(description: "testGetDogsSuccessful")
        
        self.sut.getDogs { dogs in
            XCTAssert(!dogs.isEmpty)
            if (!dogs.isEmpty) {
                let dog = dogs[0]
                XCTAssertEqual(dog.dogName, "Rex")
                XCTAssertEqual(dog.age, 5)
                XCTAssertEqual(dog.dogDescription, "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot")
            }
            expectation.fulfill()
        } onFailed: { response in
            XCTAssert(false)
            expectation.fulfill()
    
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
