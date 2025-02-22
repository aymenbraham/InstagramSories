//
//  StoryListView.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import SwiftUI

struct StoryListView: View {
    @StateObject private var viewModel = StoryViewModel()

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.users) { user in
                        if let story = viewModel.stories.first(where: { $0.userID == user.id }) {
                            StoryItemView(user: user, story: story)
                                .onTapGesture {
                                    viewModel.markStoryAsSeen(story.id)
                                }
                        }
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
            }
        }
    }
