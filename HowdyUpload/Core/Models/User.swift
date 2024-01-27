//
//  User.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 1/27/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var bio: String?
    let email: String
}
