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
        name: String) {
            self.groupPhoto.image = photo
            self.groupName.text = name
        }
}
