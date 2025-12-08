//
//  AuthorizationView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 13.08.2025.
//

import SwiftUI

struct AuthorizationView: View {
    
    @State var email = ""
    
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
                    
                    TextField("Email Address", text: $email)
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray)
                )
                .padding(.horizontal)

                HStack {
                    Image("Vector-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.leading, 7)
                        .padding(.trailing, 7)
                    
                    TextField("Password", text: $email)
                    
                    
                    Image("mdi_eye")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 7)
                    
                }
                .padding()
                .background(

                    RoundedRectangle(cornerRadius: 50)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray)
                )
                .padding()
                
                Button {
                    
                } label: {
                    Text("CONTINUE")
                        .font(.custom("Montserrat-Bold", size: 17))
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
                
                Button {
                    
                } label: {
                    HStack {
                        Image("Vector")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 7)
                        
                        
                        Text("LOGIN WITH APPLE id")
                            .font(.custom("Montserrat-Bold", size: 17))
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
                .padding(.top, 20)
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Image("flat-color-icons_google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 7)
                        
                        
                        Text("LOGIN WITH google")
                            .font(.custom("Montserrat-Bold", size: 17))
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
                    Text("Don’t have an account?")
                        .foregroundStyle(.white)
                    Button {
                        //
                    } label: {
                        Text("Sign Up")
                    }
                }
                .padding()
                .padding(.top, 10)
                
                HStack {
                    Button {
                        //
                    } label: {
                        Text("Terms of Use")
                            .font(.custom("", size: 11))
                            .foregroundStyle(.gray)
                            .underline()
                    }.padding(.horizontal, 10)
                    
                    Button {
                        //
                    } label: {
                        Text("Privacy Policy")
                            .font(.custom("", size: 11))
                            .foregroundStyle(.gray)
                            .underline()
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.top)
            }
            .padding(.top)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AuthorizationView()
}
