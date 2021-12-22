//
//  ProfileCollectionCell.swift
//  VK
//
//  Created by Polina Tikhomirova on 22.12.2021.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var age: UILabel!
    
    func configure(
        name: String,
        photo: UIImage?,
        age: String) {
            self.name.text = name
            self.photo.image = photo
            self.age.text = age
        }
}
