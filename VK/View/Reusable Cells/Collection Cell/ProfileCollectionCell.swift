//
//  ProfileCollectionCell.swift
//  VK
//
//  Created by Polina Tikhomirova on 22.12.2021.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeButton: LikeButton!
    
    func configure(
        photo: UIImage?,
        like: UIImage?) {
            self.photo.image = photo
            if let like = like {
                likeButton.likeImage = like
            }
        }
}
