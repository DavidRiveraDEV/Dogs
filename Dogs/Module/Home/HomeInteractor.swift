//
//  HomeInteractor.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    private var loadingDogsLocally: Bool = false
    
    func getDogs() {
        self.loadingDogsLocally = true
        self.localDatamanager?.getDogs()
    }
}

extension HomeInteractor: HomeLocalDataManagerOutputProtocol, HomeRemoteDataManagerOutputProtocol {
    
    func onDogsSuccess(_ dogs: [Dog]) {
        if !self.loadingDogsLocally {
            self.localDatamanager?.clearDogs()
            _ = self.localDatamanager?.saveDogs(dogs)
        } else {
            if dogs.isEmpty {
                self.loadingDogsLocally = false
                self.remoteDatamanager?.getDogs()
                return
            }
        }
        self.presenter?.updateDogs(dogs)
    }
    
    func onDogsError(_ response: FailedResponse) {
        if self.loadingDogsLocally {
            self.loadingDogsLocally = false
            self.remoteDatamanager?.getDogs()
        } else {
            self.presenter?.updateDogs([])
        }
    }
}
