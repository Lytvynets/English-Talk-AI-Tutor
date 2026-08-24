//
//  AuthorizationView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 13.08.2025.
//

import SwiftUI

struct AuthorizationView: View {
    
    @EnvironmentObject var authorizationViewModel: AuthorizationViewModel
    @State private var signIn = false
    @State private var showPassword = false
    
    var body: some View {
        
        ZStack {
            Color(hex: "#212737")
                .ignoresSafeArea()
            
            VStack {
                Image("Vector 1-2")
                    .resizable()
                    .frame(height: 200)
                
                Spacer()
            }
            
            VStack {
                Image("Group")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                
                HStack {
                    Image("Vector-3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.leading, 7)
                        .padding(.trailing, 7)
                    
                    TextField("Email Address", text: $authorizationViewModel.email)
                        .foregroundStyle(.white)
                        .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#3D4353") ?? .gray)
                )
                .padding(.horizontal)
                
                HStack {
                    Image("Vector-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.leading, 7)
                        .padding(.trailing, 7)
                    
                    if showPassword {
                        TextField("Password", text: $authorizationViewModel.password)
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    }else{
                        SecureField("Password", text: $authorizationViewModel.password)
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    }
                    
                    Image("mdi_eye")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 7)
                        .onTapGesture {
                            showPassword.toggle()
                        }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#3D4353") ?? .gray)
                )
                .padding()
                
                Button {
                    if signIn {
                        Task {
                            try await authorizationViewModel.signInWithEmail()
                        }
                    }else{
                        Task {
                            try await authorizationViewModel.signUpWithEmail()
                        }
                    }
                } label: {
                    Text(signIn ? "SIGN IN" : "SIGN UP")
                        .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                        .foregroundStyle(.white)
                        .padding(20)
                        .frame(width: UIScreen.main.bounds.width / 1.1)
                        .background {
                            LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                    Color(Color(hex: "#38A9CF") ?? .blue)],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        }
                }
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(.bottom, 20)
                
                Image("Frame 220")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                
                AppleSignInButton()
                    .signInWithAppleButtonStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 62)
                    .mask(RoundedRectangle(cornerRadius: 50))
                    .onTapGesture {
                        authorizationViewModel.startSignInWithAppleFlow()
                    }
                    .padding()
                
                Button {
                    Task {
                        try await authorizationViewModel.signInWithGoogle()
                    }
                } label: {
                    HStack {
                        Image("flat-color-icons_google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 7)
                        
                        Text("Sign in with Google")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive18))
                            .foregroundStyle(.white)
                    }
                    .padding(20)
                    .frame(width: UIScreen.main.bounds.width / 1.1)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.white)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(.top, 10)
                
                HStack {
                    Text(signIn ? "Don’t have an account?" : "Already have an account?")
                    Button {
                        signIn.toggle()
                    } label: {
                        Text(signIn ? "Sign Up" : "Sign in" )
                            .foregroundStyle(Color(hex: "#38A9CF") ?? .blue)
                    }
                }
                .foregroundStyle(.white)
                .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                .padding()
                .padding(.top, 10)
                
                HStack {
                    Button {
                        openURL(AppDefaults.termsOfUseURL)
                    } label: {
                        Text("Terms of Use")
                            .underline()
                    }.padding(.horizontal, 11)
                    
                    Button {
                        openURL(AppDefaults.privacyPolicyURL)
                    } label: {
                        Text("Privacy Policy")
                            .underline()
                    }
                    .padding(.horizontal, 11)
                }
                .foregroundStyle(Color(hex: "#A3A3A3") ?? .gray)
                .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive11))
                .padding(.top)
            }
            .padding(.top)
        }
        .ignoresSafeArea()
        .overlay {
            if authorizationViewModel.isLoading {
                ProgressView()
                    .tint(.gray)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray.opacity(0.75))
            }
        }
    }
    
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    AuthorizationView()
        .environmentObject(AuthorizationViewModel())
}
