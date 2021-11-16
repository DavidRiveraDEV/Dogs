//
//  HomeRemoteDataManager.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation

class HomeRemoteDataManager {
    
    var dataManagerRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    let remoteDogsService: RemoteDogsService
    
    init() {
        self.remoteDogsService = RemoteDogsService()
    }
}

extension HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    func getDogs() {
        self.remoteDogsService.getDogs { [weak self] dogs in
            self?.dataManagerRequestHandler?.onDogsSuccess(dogs)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onDogsError(response)
        }
    }
}
