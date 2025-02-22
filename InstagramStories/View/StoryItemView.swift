//
//  StoryItemView.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import SwiftUI

struct StoryItemView: View {
    let user: User
    let story: Story
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.profile_picture_url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(story.isSeen ? Color.gray : Color.blue, lineWidth: 3)
            )
            
            Text(user.name)
                .font(.caption)
                .lineLimit(1)
        }
    }
}
