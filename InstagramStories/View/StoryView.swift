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
    var user: User
    @Binding var isPresented: Bool
    private static let isLikedKey = "isLiked_"
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: user.story?.imageURL ?? "")) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        UserProfileView(user: user)
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
                            Image(systemName: isLiked  ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.padding(.leading, 8)
                    }.padding()
                }
            }
        }.background(.black)
            .onAppear() {
                isLiked = StoryView.loadLikedState(for: user.id)
            }
    }
    
    func dismissView() {
        isPresented = false
    }
    
    func likeStoryAction() {
        isLiked.toggle()
        StoryView.saveLikedState(isLiked, for: user.id)
        if let index = viewModel.users.firstIndex(where: { $0.id == user.id }) {
            viewModel.users[index].story?.isLiked = isLiked
        }
    }
    
    // MARK: - UserDefaults Helpers
    
    // Save the isLiked state to UserDefaults
    private static func saveLikedState(_ isLiked: Bool, for userID: Int) {
        UserDefaults.standard.set(isLiked, forKey: "\(isLikedKey)\(userID)")
    }
    
    // Load the isLiked state from UserDefaults
    private static func loadLikedState(for userID: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(isLikedKey)\(userID)")
    }
}

struct UserProfileView: View {
    var user: User
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.profile_picture_url)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .cornerRadius(50)
            VStack(alignment: .leading) {
                Text(user.name).font(.system(size: 20).weight(.medium)).foregroundColor(.white)
            }
        }
    }
}
