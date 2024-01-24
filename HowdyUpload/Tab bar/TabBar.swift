//
//  TabBar.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 11/27/23.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case settings = 1
    case showroom = 2
    case poll = 3
}

struct TabBar: View {
    @Binding var selectedTabs: Tabs

    var body: some View {
        HStack(alignment: .center) {
            Button {
                // Home screen
                selectedTabs = .home
            } label: {
                TabBarButton(buttonText: "Home",
                             imageName: "house",
                             isActive: selectedTabs == .home)
            }
            .tint(Color.accentColor) // Use adaptive color

            Button {
                // Video screen
                selectedTabs = .showroom
            } label: {
                TabBarButton(buttonText: "Showroom",
                             imageName: "photo.circle.fill",
                             isActive: selectedTabs == .showroom)
            }
            .tint(Color.accentColor) // Use adaptive color

            Button {
                // New chat
                selectedTabs = .poll
            } label: {
                TabBarButton(buttonText: "Poll",
                             imageName: "chart.bar.doc.horizontal.fill",
                             isActive: selectedTabs == .poll)
            }
            .tint(Color.accentColor) // Use adaptive color

            Button {
                // Switch to settings
                selectedTabs = .settings
            } label: {
                TabBarButton(buttonText: "Settings",
                             imageName: "gear",
                             isActive: selectedTabs == .settings)
            }
            .tint(Color.accentColor) // Use adaptive color
        }
        .frame(height: 82)
        .accentColor(Color(.orange)) // Set your primary accent color here
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTabs: .constant(.home))
    }
}

