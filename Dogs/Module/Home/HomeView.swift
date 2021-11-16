//
//  HomeView.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation
import UIKit

class HomeView: UIViewController {

    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeView: HomeViewProtocol {
    
    func updateDogs(_ dogs: [Dog]) {
        
    }
}
