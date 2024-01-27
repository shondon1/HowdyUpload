//
//  UploadMessageView.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 1/22/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct UploadMessageView: View {
    @State private var message: String = ""

    var body: some View {
        VStack {
            TextField("Enter message", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Upload Message") {
                // Implement upload logic
                uploadMessage()
            }
            .padding()
        }
        .navigationTitle("Upload Message")
    }

    private func uploadMessage() {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("messages").addDocument(data: [
            "username": "YourUsername",  // Replace with your username
            "profilePictureURL": "YourProfilePicURL",  // Replace with your profile picture URL
            "message": message,
            "timestamp": Timestamp(date: Date())
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}


#Preview {
    UploadMessageView()
}
