//
//  UserModel.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let profilePictureURL: String
}
