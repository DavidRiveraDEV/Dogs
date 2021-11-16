//
//  HomePresenter.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation

class HomePresenter {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        self.interactor?.getDogs()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func updateDogs(_ dogs: [Dog]) {
        self.view?.updateDogs(dogs)
    }
}
