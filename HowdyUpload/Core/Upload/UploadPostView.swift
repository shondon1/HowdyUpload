//
//  UploadPostView.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 1/22/24.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseStorage
import AVKit
struct UploadPostView: View {
    @State private var caption: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var selectedVideoURL: URL?
    // Add more states as needed for photo/video upload

    var body: some View {
        VStack {
            Button("Select Photo") {
                isImagePickerPresented = true
            }
            .padding()
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            }
            if let selectedVideoURL = selectedVideoURL {
                         VideoPlayer(player: AVPlayer(url: selectedVideoURL))
                             .frame(height: 200)
                     }
            
            TextField("Enter caption", text: $caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Upload Post") {
                uploadPost()
            }
            .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, selectedVideoURL: $selectedVideoURL)
        }
        .navigationTitle("Upload Post")
    }

    private func handleVideoSelection(url: URL) {
        self.selectedVideoURL = url
        // Additional logic if needed
    }
    
    private func uploadPost() {
        if let selectedImage = selectedImage {
            uploadImage(selectedImage)
        } else if let selectedVideoURL = selectedVideoURL {
            uploadVideo()
        } else {
            print("No media selected")
        }
    }
    
    private func uploadImage(_ image: UIImage) {
        // Assuming `selectedPhoto` is the UIImage you want to upload
        guard let selectedImage = selectedImage, let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
                    print("No image selected")
                    return
                }

        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child("posts/\(UUID().uuidString).jpg")

        photoRef.putData(imageData, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                // Handle the error
                print("Error uploading photo: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            photoRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    // Handle the error
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Here, you have your download URL, you can now save it along with the caption to Firestore
                savePostToFirestore(mediaURL: downloadURL.absoluteString, caption: caption, isVideo: false)

            }
        }
    }
    
    private func uploadVideo() {
        guard let selectedVideoURL = selectedVideoURL else {
            print("No video selected")
            return
        }

        let storageRef = Storage.storage().reference()
        let videoRef = storageRef.child("posts/\(UUID().uuidString).mov")

        videoRef.putFile(from: selectedVideoURL, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                print("Error uploading video: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            videoRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Save the video URL along with the caption to Firestore
                savePostToFirestore(mediaURL: downloadURL.absoluteString, caption: caption, isVideo: true)
            }
        }
    }
    
    private func savePostToFirestore(mediaURL: String, caption: String, isVideo: Bool) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("posts").addDocument(data: [
            "username": "YourUsername",
            "profilePictureURL": "YourProfilePicURL",
            "mediaURL": mediaURL,
            "caption": caption,
            "timestamp": Timestamp(date: Date()),
            "isVideo": isVideo  // Add a flag to distinguish between video and photo posts
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
    UploadPostView()
}
