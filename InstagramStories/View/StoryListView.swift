//
//  StoryListView.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import SwiftUI

struct StoryListView: View {
    @StateObject private var viewModel = StoryViewModel()
    @State private var selectedUser: User? = nil
    @State private var isPresentingSheet = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.users) { user in
                    StoryItemView(user: user, story: user.story ?? Story(id: 0, userID: 0, imageURL: "", isSeen: false, isLiked: false))
                        .onTapGesture {
                            selectedUser = user
                            viewModel.markStoryAsSeen(forUserID: user.id)  // Mark as seen when tapped
                            isPresentingSheet.toggle()
                        }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .fullScreenCover(isPresented: $isPresentingSheet) {
            StoryView(user: $selectedUser, isPresented: $isPresentingSheet)
        }
        .onAppear {
            viewModel.loadUsers()
        } .onChange(of: selectedUser) { newUser in
            if let user = newUser {
                viewModel.markStoryAsSeen(forUserID: user.id)
            }
            
        }
    }
}
