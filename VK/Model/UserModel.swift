//
//  UserModel.swift
//  VK
//
//  Created by Polina Tikhomirova on 22.12.2021.
//

import UIKit

struct UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.userSurname == rhs.userSurname
    }
    
    let userFirstName: String
    let userSurname: String
    let userPhoto: UIImage?
    var userPhotos: [UIImage]
    let userAge: Int
    let id: Int
}
