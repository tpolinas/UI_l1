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
    @IBOutlet var likeCounter: UILabel!
    
    @IBAction func like(_ sender: Any) {
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeCounter.text = "0"
            likeButton.tag = 1
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCounter.text = "1"
            likeButton.tag = 0
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
