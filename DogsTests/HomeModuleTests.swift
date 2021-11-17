//
//  HomeModuleTests.swift
//  DogsTests
//
//  Created by David Rivera on 16/11/21.
//

import XCTest
@testable import Dogs

class HomeModuleTests: XCTestCase {
    
    var interactor: HomeInteractor!
    var presenterLocallySuccess: HomePresenterLocallySuccessMock!
    var presenterRemotelySuccess: HomePresenterRemotelySuccessMock!
    var localDataManager: HomeLocalDataManager!
    var remoteDataManager: HomeRemoteDataManager!
    
    override func setUp() {
        super.setUp()
        self.presenterLocallySuccess = HomePresenterLocallySuccessMock()
        self.presenterRemotelySuccess = HomePresenterRemotelySuccessMock()
        self.interactor = HomeInteractor()
        self.localDataManager = HomeLocalDataManager()
        self.remoteDataManager = HomeRemoteDataManager()
        
        self.presenterLocallySuccess.interactor = self.interactor
        self.presenterRemotelySuccess.interactor = self.interactor
        self.interactor.localDatamanager = self.localDataManager
        self.interactor.remoteDatamanager = self.remoteDataManager
        self.localDataManager.dataManagerRequestHandler = self.interactor
        self.remoteDataManager.dataManagerRequestHandler = self.interactor
        
        self.localDataManager.clearDogs()
    }
    
    override func tearDown() {
        self.presenterLocallySuccess = nil
        self.presenterRemotelySuccess = nil
        self.interactor = nil
        self.localDataManager.clearDogs()
        super.tearDown()
    }
    
    func testGetDogsLocallySuccessful() {
        self.saveDogs()
        self.presenterLocallySuccess.expectation = expectation(description: "testGetDogsLocallySuccessful")
        self.interactor.presenter = self.presenterLocallySuccess
        self.presenterLocallySuccess.viewDidLoad()
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetDogsRemotelySuccessful() {
        self.presenterRemotelySuccess.expectation = expectation(description: "testGetDogsLocallySuccessful")
        self.interactor.presenter = self.presenterRemotelySuccess
        self.presenterRemotelySuccess.viewDidLoad()
        waitForExpectations(timeout: 3, handler: nil)
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
        _ = self.localDataManager.saveDogs(dogs)
    }
}

class HomePresenterLocallySuccessMock: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    var expectation: XCTestExpectation?
    
    func viewDidLoad() {
        self.interactor?.getDogs()
    }
    
    func updateDogs(_ dogs: [Dog]) {
        XCTAssert(!dogs.isEmpty)
        XCTAssertEqual(dogs.count, 2)
        if (!dogs.isEmpty) {
            let dog = dogs[0]
            XCTAssertEqual(dog.dogName, "Rex")
            XCTAssertEqual(dog.age, 5)
            XCTAssertEqual(dog.dogDescription, "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot")
        }
        expectation?.fulfill()
    }
    
    func onNetworkError() {}
}


class HomePresenterRemotelySuccessMock: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    var expectation: XCTestExpectation?
    
    func viewDidLoad() {
        self.interactor?.getDogs()
    }
    
    func updateDogs(_ dogs: [Dog]) {
        XCTAssert(!dogs.isEmpty)
        XCTAssert(dogs.count > 2)
        if (!dogs.isEmpty) {
            let dog = dogs[0]
            XCTAssertEqual(dog.dogName, "Rex")
            XCTAssertEqual(dog.age, 5)
            XCTAssertEqual(dog.dogDescription, "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot")
        }
        expectation?.fulfill()
    }
    
    func onNetworkError() {}
}
