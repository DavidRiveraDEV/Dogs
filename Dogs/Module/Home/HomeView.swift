//
//  HomeView.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//  

import Foundation
import UIKit

class HomeView: UIViewController {
    
    @IBOutlet private weak var dogsTableView: UITableView!

    var presenter: HomePresenterProtocol?
    
    private var dogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        self.presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.dogsTableView.delegate = self
        self.dogsTableView.dataSource = self
        self.dogsTableView.register(UINib(nibName: "DogViewCell", bundle: nil), forCellReuseIdentifier: "DogViewCell")
    }
}

extension HomeView: HomeViewProtocol {
    
    func updateDogs(_ dogs: [Dog]) {
        self.dogs = dogs
        DispatchQueue.main.async {
            self.dogsTableView.reloadData()
        }
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: HomeView.NETWORK_ERROR_ALERT_TITLE_LOCALIZABLE_STRING_KEY.localize(),
            message: HomeView.NETWORK_ERROR_ALERT_MESSAGE_LOCALIZABLE_STRING_KEY.localize(),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: HomeView.NETWORK_ERROR_ALERT_BUTTON_LOCALIZABLE_STRING_KEY.localize(),
            style: .default,
            handler: { action in
                self.presenter?.viewDidLoad()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DogViewCell", for: indexPath) as? DogViewCell {
            cell.dog = dogs[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension HomeView {
    
    static let NETWORK_ERROR_ALERT_TITLE_LOCALIZABLE_STRING_KEY = "HomeView.networkAlert.title"
    static let NETWORK_ERROR_ALERT_MESSAGE_LOCALIZABLE_STRING_KEY = "HomeView.networkAlert.message"
    static let NETWORK_ERROR_ALERT_BUTTON_LOCALIZABLE_STRING_KEY = "HomeView.networkAlert.button"
}
