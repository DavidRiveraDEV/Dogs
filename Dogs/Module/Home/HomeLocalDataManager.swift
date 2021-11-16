//
//  HomeLocalDataManager.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation

class HomeLocalDataManager {
    
    var dataManagerRequestHandler: HomeLocalDataManagerOutputProtocol?
    
    let localDogsService: LocalDogsService
    
    init() {
        self.localDogsService = LocalDogsService()
    }
}

extension HomeLocalDataManager: HomeLocalDataManagerInputProtocol {
    
    func saveDogs(_ dogs: [Dog]) -> Bool {
        return self.localDogsService.saveDogs(dogs)
    }
    
    func getDogs() {
        self.localDogsService.getDogs { [weak self] dogs in
            self?.dataManagerRequestHandler?.onDogsSuccess(dogs)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onDogsError(response)
        }
    }
    
    func clearDogs() {
        self.localDogsService.clearDogs()
    }
}


