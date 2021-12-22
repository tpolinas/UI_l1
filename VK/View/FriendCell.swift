//
//  FriendCell.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet var friendPhoto: UIImageView!
    @IBOutlet var friendName: UILabel!
    
    func configure(
        photo: UIImage,
        name: String) {
            self.friendPhoto.image = photo
            self.friendName.text = name
        }
}
