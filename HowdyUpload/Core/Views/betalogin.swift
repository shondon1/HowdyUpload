//
//  betalogin.swift
//  HowdyUpload
//
//  Created by Rashon Hyslop on 11/28/23.
//

import SwiftUI

struct BetaLoginin: View {
    var body: some View {
        ZStack {
            Color(hex: "8EDCE6").ignoresSafeArea()
            
            VStack(spacing: 10){
                Text("The Exbhit")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                //Login in Button
                VStack(spacing: 12){
                    Button(action: {
                        // Add action for sign in here
                    }) {
                        Text("Login in")
                            .foregroundColor(Color.black)
                            .fontWeight(.heavy)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "EF798A"))
                            .cornerRadius(5)
                    }
                    .padding(.top, 10)
                    
                    Button(action: {
                        // Add action for sign in here
                        
                    }) {
                        Text("Sign up")
                            .foregroundColor(Color.black)
                            .fontWeight(.heavy)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "D5DCF9"))
                            .cornerRadius(5)
                    }
                    .padding(.top, 10)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        self.init(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
        )
    }
}

#Preview {
    BetaLoginin()
}

