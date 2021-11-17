//
//  HomeProtocols.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func updateDogs(_ dogs: [Dog])
    func showNetworkError()
}

protocol HomeRouterProtocol: AnyObject {
    
    static func createModule() -> UIViewController
}

protocol HomePresenterProtocol: AnyObject {

    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    
    func updateDogs(_ dogs: [Dog])
    func onNetworkError()
}

protocol HomeInteractorInputProtocol: AnyObject {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    func getDogs()
}

protocol HomeDataManagerInputProtocol: AnyObject {
    
    func getDogs()
}

protocol HomeDataManagerOutputProtocol: AnyObject {
    
    func onDogsSuccess(_ dogs: [Dog])
    func onDogsError(_ response: FailedResponse)
}

protocol HomeRemoteDataManagerInputProtocol: HomeDataManagerInputProtocol {
    
    var dataManagerRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
}

protocol HomeRemoteDataManagerOutputProtocol: HomeDataManagerOutputProtocol {
    
}

protocol HomeLocalDataManagerInputProtocol: HomeDataManagerInputProtocol {
    
    var dataManagerRequestHandler: HomeLocalDataManagerOutputProtocol? { get set }
    
    func saveDogs(_ dogs: [Dog]) -> Bool
    func clearDogs()
}

protocol HomeLocalDataManagerOutputProtocol: HomeDataManagerOutputProtocol {
    
}
