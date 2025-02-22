//
//  StoryViewModel.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import Foundation

class StoryViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func loadUsers() {
        guard let url = URL(string: "https://file.notion.so/f/f/217d0d1c-7a97-42dd-91c5-2c6314c29174/56226368-cb1a-4572-a037-655366fc8071/users.json?table=block&id=1a0a0b48-1db4-8072-82db-c5aceda9f98d&spaceId=217d0d1c-7a97-42dd-91c5-2c6314c29174&expirationTimestamp=1740243988091&signature=JjHsjDkuoAt2fdepkZC1jx31a2u9UgrfnoPim_uDT_0&downloadName=users.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Decode the JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
                // Flatten the array of users from all pages
                var allUsers = decodedResponse.pages.flatMap { $0.users }
                
                // Add static stories to each user
                for index in 0..<allUsers.count {
                    let user = allUsers[index]
                    let staticStory = Story(id: index, userID: user.id, imageURL: "https://i.pravatar.cc/300?u=\(user.id)", isSeen: false, isLiked: false)
                    allUsers[index].story = staticStory  // Add story to user
                }
                
                DispatchQueue.main.async {
                    self.users = allUsers
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func markStoryAsSeen(forUserID userID: Int) {
        // Find the user by userID
        if let userIndex = users.firstIndex(where: { $0.id == userID }) {
            var user = users[userIndex]
            // Check if the user has a story, then mark it as seen
            if var story = user.story, !story.isSeen {
                story.isSeen = true
                user.story = story  // Update the user's story
                users[userIndex] = user  // Update the user in the array
            }
        }
    }
}
