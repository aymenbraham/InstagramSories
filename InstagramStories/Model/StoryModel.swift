//
//  StoryModel.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import Foundation

struct Story: Identifiable, Codable {
    let id: Int
    let userID: Int
    let imageURL: String
    var isSeen: Bool
    var isLiked: Bool
}
