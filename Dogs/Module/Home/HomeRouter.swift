//
//  HomeRouter.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {

    class func createModule() -> UIViewController {
        if let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeView") as? HomeView {
            let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
            let interactor: HomeInteractorInputProtocol & HomeLocalDataManagerOutputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
            let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
            let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
            let router: HomeRouterProtocol = HomeRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            localDataManager.dataManagerRequestHandler = interactor
            remoteDataManager.dataManagerRequestHandler = interactor
            
            return view
        }
        return UIViewController()
    }
}
