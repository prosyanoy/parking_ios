//
//  ProfileCell.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 07.09.2022.
//

import Foundation

struct ProfileInfo: Codable {
    var surname: String?
    var name: String?
    var patronymic: String?
    var email: String?
    
    init(surname: String?, name: String?, patronymic: String?, phone: String?, email: String?) {
        self.surname = surname
        self.name = name
        self.patronymic = patronymic
        self.email = email
    }
}
