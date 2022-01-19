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
    
    func configure(
        photo: UIImage,
        name: String,
        surname: String) {
            self.friendPhoto.image = photo
            self.friendName.text = name
            self.friendSurname.text = surname
        }
}
