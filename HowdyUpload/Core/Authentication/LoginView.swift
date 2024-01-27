//
//  LoginView.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 11/29/23.
//

import SwiftUI
import PhotosUI
import Firebase

struct LoginView: View {
// This is for the Login to be able to see
    @State var emailID: String = ""
    @State var password: String = ""
    //MARK: View properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    var body: some View {
        VStack(spacing: 10){
            Text("Glad to see you :)")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Welcome Back, \nYou have been missed")
                .font(.title3)
                .hAlign(.leading)
            
            VStack(spacing: 12){
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top,25)
                
                SecureField("Your secert password :) ", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top,25)
                
                Button("Need to reset your password?", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(Color(hex: 0x247ba0))
                    .hAlign(.trailing)
                
                Button(action: loginUser){
                    
                    //MARK: Login Button
                    Text("Sign in")
                        .foregroundColor(Color(hex: 0xef8354))
                        .fontWeight(.heavy)
                        .hAlign(.center)
                        .fillView(Color(hex: 0xe0e1dd))
                }
                .padding(.top, 10)
            }
            
            //MARK: Register Button
            HStack{
                Text("Dont have an account?")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x00000))

                Button("Register Now"){
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(Color(hex: 0x1e91d6))
            }
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        //MARK: Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount){
            RegisterView()
        }
        //MARK: Displaying Alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func  loginUser(){
        Task{
            do{
                // With the help of Swift Concurrency Auth can be done with Signla Line
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
            }catch{
                await setError(error)
            }
        }
    }
    
    func resetPassword() {
        Task{
            do{
                // With the help of Swift Concurrency Auth can be done with Signla Line
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link sent")
            }catch{
                await setError(error)
            }
        }
    }
    // MARK: Displaying Errors VIA Alert
    func setError(_ error: Error)async{
        // MARK: UI MUST be Updated on Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

//MARK: Register View
struct RegisterView: View{
    @State var emailID: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State var userbio: String = ""
    @State var userlink: String = ""
    @State var userProfilePicData: Data?
    //MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    var body: some View {
        VStack(spacing: 10){
            Text("Time to join the club")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Let's get you started ")
                .font(.title3)
                .hAlign(.leading)
            
            // MARK: For Smaller Size Optimization
            ViewThatFits{
                ScrollView(.vertical, showsIndicators: false){
                    HelperView()
                }
                
                HelperView()
            }
            //MARK: Register Button
            HStack{
                Text("Already have an account?")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x00000))

                Button("Login In"){
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundColor(Color(hex: 0x1e91d6))
            }
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            //MARK: Extracting UIImage From PhotoItem
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                        // MARK: UI Must be Upadated on Main Thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
    }
    
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 12){
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top,25)
        
            TextField("Username", text: $username)
                .textContentType(.username)
                .border(1, .gray.opacity(0.5))
            
            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("UserBio", text: $userbio, axis: .vertical)
                .frame(minHeight: 100,alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("Social link (Optional For real!)", text: $userlink)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            SecureField("Your secert password :) ", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            Button("Need to reset your password?", action: {})
                .font(.callout)
                .fontWeight(.medium)
                .tint(Color(hex: 0x247ba0))
                .hAlign(.trailing)
            
            Button(action: registerUser){
                
                //MARK: Sign up button
                Text("Sign UP")
                    .foregroundColor(Color(hex: 0xe0e1dd))
                    .fontWeight(.heavy)
                    .hAlign(.center)
                    .fillView(Color(hex: 0xef8354))
            }
            .padding(.top, 10)
        }

    }
    func registerUser(){
        Task{
            do{
                
            }catch{
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

// MARK: View Extensions for UI Building
extension View{
    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    //MARK: Custom Border View with Padding
    func border(_ width: CGFloat, _ color: Color)-> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical,10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    //MARK: Custom Fill view with padding
    func fillView(_ color: Color)-> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical,10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
    
}


//Just trying something
                    extension Color {
                        init(hex: UInt32, alpha: Double = 1.0) {
                            let red = Double((hex >> 16) & 0xFF) / 255.0
                            let green = Double((hex >> 8) & 0xFF) / 255.0
                            let blue = Double(hex & 0xFF) / 255.0
                            self.init(red: red, green: green, blue: blue, opacity: alpha)
                        }
                    }
