//
//  HomeView.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 1/27/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink("Upload Post", destination: UploadPostView())
            NavigationLink("Upload comment", destination: UploadMessageView())
            NavigationLink("Edit Profile", destination: EditProfile())
        }
    }
}

#Preview {
    HomeView()
}
