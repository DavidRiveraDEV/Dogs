//
//  LocalDogsServiceTests.swift
//  DogsTests
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

import XCTest
@testable import Dogs

class LocalDogsServiceTests: XCTestCase {
    
    private var sut: LocalDogsService!
    
    override func setUp() {
        super.setUp()
        self.sut = LocalDogsService()
        self.saveDogs()
    }
    
    override func tearDown() {
        self.sut.clearDogs()
        self.sut = nil
        super.tearDown()
    }
    
    func testGetDogsSuccessful() throws {
        
        let expectation = expectation(description: "testGetDogsSuccessful")
        
        self.sut.getDogs { dogs in
            XCTAssert(!dogs.isEmpty)
            XCTAssertEqual(dogs.count, 2)
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
    
    private func saveDogs() {
        var rex = Dog()
        rex.dogName = "Rex"
        rex.dogDescription = "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot"
        rex.age = 5
        rex.image = "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634"
        
        var spots = Dog()
        spots.dogName = "Spots"
        spots.dogDescription = "Is the brother of Chief and are also a former guard dog for Mayor Kobayashi's ward"
        spots.age = 3
        spots.image = "https://static.wikia.nocookie.net/isle-of-dogs/images/6/6b/Spots.jpg/revision/latest/scale-to-width-down/666?cb=20180624191101"
        
        let dogs = [
            rex,
            spots
        ]
        _ = self.sut.saveDogs(dogs)
    }
}

