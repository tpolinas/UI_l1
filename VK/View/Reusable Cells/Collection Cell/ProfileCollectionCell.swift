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
    @IBOutlet var likeButton: UIButton!
    
    @IBAction func like(_ sender: Any) {
        if likeButton.titleLabel?.text == "0" {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.setTitle("1", for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.setTitle("0", for: .normal)
        }
    }
    
    func configure(
        name: String,
        photo: UIImage?,
        age: String) {
            self.name.text = name
            self.photo.image = photo
            self.age.text = age
        }
}
