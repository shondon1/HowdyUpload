//
//  ContentView.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 11/24/23.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Upload Post", destination: UploadPostView())
                NavigationLink("Upload comment", destination: UploadMessageView())
                NavigationLink("Edit Profile", destination: EditProfile())
            }
            .navigationBarTitle("Uploader App")
        }
    }
}


#Preview {
    ContentView()
}
