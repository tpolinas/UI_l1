//
//  FriendCell.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet var friendPhoto: AvatarImage!
    @IBOutlet var friendName: UILabel!
    @IBOutlet var friendSurname: UILabel!
    
    
    public func animateMe() {
        AvatarImage.animate(
            withDuration: 2,
            delay: 0.0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 1.0) {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            } completion: { _ in
                self.transform = .identity
            }
      }
    
    
    func configure(
        photo: UIImage,
        name: String,
        surname: String) {
            self.friendPhoto.image = photo
            self.friendName.text = name
            self.friendSurname.text = surname
        }
}
