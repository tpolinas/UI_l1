//
//  GroupCell.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

final class GroupCell: UITableViewCell {
    @IBOutlet var groupPhoto: UIImageView!
    @IBOutlet var groupName: UILabel!
    
    func configure(
        photo: UIImage,
        name: String) {
            self.groupPhoto.image = photo
            self.groupName.text = name
        }
}
