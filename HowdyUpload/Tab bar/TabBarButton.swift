//
//  TabBarButton.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 11/27/23.

import SwiftUI

struct TabBarButton: View {
    var buttonText: String
    var imageName: String
    var isActive: Bool

    var body: some View {
        GeometryReader { geo in
            if isActive {
                Rectangle()
                    .foregroundColor(Color.accentColor)
                    .frame(width: geo.size.width / 2, height: 4)
                    .padding(.leading, geo.size.width / 4)
            }

            VStack(alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isActive ? Color.accentColor : Color.primary)

                Text(buttonText)
                    .font(Font.custom("Poppins", size: 12).weight(.medium))
                    .foregroundColor(isActive ? Color.accentColor : Color.primary)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "home", imageName: "house", isActive: true)
    }
}
