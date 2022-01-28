//
//  ProfileCollectionCell.swift
//  VK
//
//  Created by Polina Tikhomirova on 22.12.2021.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    @IBOutlet var photo: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    var isLiked: Bool = false
    
    @IBAction func like(_ sender: Any) {
        animate()
    }
    
    private func animate() {
        UIButton.animate(withDuration: 0.1, animations: {
            switch self.isLiked {
            case false:
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.likeButton.setTitle("1", for: .normal)
                self.isLiked = true
            default:
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.likeButton.setTitle("0", for: .normal)
                self.isLiked = false
            }
          self.transform = self.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
            UIButton.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
          })
        })
      }
    
    func configure(
        name: String,
        photo: UIImage?,
        age: String) {
            self.photo.image = photo
        }
}
