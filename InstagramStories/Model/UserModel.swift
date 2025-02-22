//
//  UserModel.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import Foundation

struct UsersResponse: Decodable {
    let pages: [Page]
}

struct Page: Decodable {
    let users: [User]
}

struct User: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let profile_picture_url: String
    var story: Story?
    
    // Conform to Equatable protocol
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
