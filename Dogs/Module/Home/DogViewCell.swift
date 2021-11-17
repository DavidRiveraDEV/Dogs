//
//  DogViewCell.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import UIKit

class DogViewCell: UITableViewCell {
    
    @IBOutlet private weak var dogImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    var dog: Dog? {
        didSet {
            self.updateView()
        }
    }
    
    private func updateView() {        
        if let imageUrl = self.dog?.image, let url = URL(string: imageUrl) {
            self.dogImageView.kf.setImage(with: url)
        }
        self.nameLabel.text = self.dog?.dogName
        self.descriptionLabel.text = self.dog?.dogDescription
        self.ageLabel.text = String(format: DogViewCell.AGE_LOCALIZABLE_STRING_KEY.localize(), self.dog?.age ?? 1)
    }
}

extension DogViewCell {
    
    static let AGE_LOCALIZABLE_STRING_KEY = "DogViewCell.label.age"
}
