//
//  HowdyUploadApp.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 11/24/23.
//

import SwiftUI
import Firebase

@main
struct HowdyUploadApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
