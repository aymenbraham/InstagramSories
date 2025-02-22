//
//  UserProfileView.swift
//  InstagramStories
//
//  Created by aymen braham on 22/02/2025.
//

import SwiftUI

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
