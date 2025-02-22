//
//  StoryView.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import SwiftUI

struct StoryView: View {
    @StateObject var viewModel = StoryViewModel()
    @State var isLiked: Bool = false
    @Binding var user: User?
    @Binding var isPresented: Bool
    @State private var currentPage: Int = 0
    private static let isLikedKey = "isLiked_"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // User's current story image
                AsyncImage(url: URL(string: user?.story?.imageURL ?? "")) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                
                VStack {
                    HStack {
                        UserProfileView(user: user ?? User(id: 0, name: "", profile_picture_url: "", story: Story(id: 0, userID: 0, imageURL: "", isSeen: false, isLiked: false)))
                            .padding(.leading)
                        Spacer()
                        Button(action: dismissView) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.padding(.top, -10)
                            .padding(.trailing)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: likeStoryAction) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.padding(.leading, 8)
                    }.padding()
                }
            }
            .background(.black)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        // Detect swipe direction
                        if value.translation.width < 0 {  // Swipe Left
                            goToNextUser()
                        } else if value.translation.width > 0 {  // Swipe Right
                            goToPreviousUser()
                        }
                    }
            )
            .onAppear {
                viewModel.loadUsers()
                currentPage =  ((user?.id ?? 0) - 1)
                print(currentPage)
                isLiked = StoryView.loadLikedState(for: user?.id ?? 0)
            }.onChange(of: user) { newUser in
                // When the user changes, update the liked state for the new user
                if let userID = newUser?.id {
                    isLiked = StoryView.loadLikedState(for: userID)
                }
            }
        }
    }
    
    func dismissView() {
        isPresented = false
    }
    
    func likeStoryAction() {
        guard let userID = user?.id else { return }
        // Toggle the liked state for the current user
        isLiked.toggle()
        // Save the liked state in UserDefaults specific to the current user
        StoryView.saveLikedState(isLiked, for: userID)
        
        // Update the liked state in the view model for the current user
        if let index = viewModel.users.firstIndex(where: { $0.id == userID }) {
            viewModel.users[index].story?.isLiked = isLiked
        }
    }
    
    func goToNextUser() {
        if currentPage < viewModel.users.count - 1 {
            if let currentUser = user {
                viewModel.markStoryAsSeen(forUserID: currentUser.id)
            }
            currentPage += 1
            user = viewModel.users[currentPage]
            if let nextUser = user {
                viewModel.markStoryAsSeen(forUserID: nextUser.id)
            }
        }
    }
    
    func goToPreviousUser() {
        if currentPage > 0 {
            if let currentUser = user {
                viewModel.markStoryAsSeen(forUserID: currentUser.id)
            }
            currentPage -= 1
            user = viewModel.users[currentPage]
            if let previousUser = user {
                viewModel.markStoryAsSeen(forUserID: previousUser.id)
            }
        }
    }
    
    // MARK: - UserDefaults Helpers
    private static func saveLikedState(_ isLiked: Bool, for userID: Int) {
        UserDefaults.standard.set(isLiked, forKey: "\(isLikedKey)\(userID)")
    }
    
    private static func loadLikedState(for userID: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(isLikedKey)\(userID)")
    }
}

