//
//  StoryViewModel.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import Foundation

class StoryViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var stories: [Story] = []

    init() {
        loadUsers()
        loadStories()
    }

    func loadUsers() {
        // Simulating user data
        users = [
            User(id: 1, name: "Neo", profilePictureURL: "https://i.pravatar.cc/300?u=1"),
            User(id: 2, name: "Trinity", profilePictureURL: "https://i.pravatar.cc/300?u=2"),
            User(id: 3, name: "Morpheus", profilePictureURL: "https://i.pravatar.cc/300?u=3"),
        ]
    }

    func loadStories() {
        // Simulating story data
        stories = [
            Story(id: 101, userID: 1, imageURL: "https://source.unsplash.com/random/300x500?sig=1", isSeen: false),
            Story(id: 102, userID: 2, imageURL: "https://source.unsplash.com/random/300x500?sig=2", isSeen: false),
            Story(id: 103, userID: 3, imageURL: "https://source.unsplash.com/random/300x500?sig=3", isSeen: false),
        ]
    }

    func markStoryAsSeen(_ storyID: Int) {
        if let index = stories.firstIndex(where: { $0.id == storyID }) {
            stories[index].isSeen = true
        }
    }
}
