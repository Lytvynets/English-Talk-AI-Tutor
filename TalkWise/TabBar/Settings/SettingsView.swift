//
//  SettingsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.08.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State var NotificationsIsOn = false
    
    var body: some View {
        
        ZStack {
            
            Color(hex: "#212737")
                .ignoresSafeArea()
            
            VStack {
                Image("Vector 28654363")
                    .resizable()
                    .frame(height: 200)
                
                Spacer()
            }
            
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    Spacer()
                    
                    Text("Settings")
                        .font(.custom("Montserrat-Bold", size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        print("")
                    } label: {
                        Text("Save")
                            .font(.custom("Montserrat-Medium", size: 17))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.top, 10)
            .background( Color(hex: "#212737"))
            .padding(.top, 63)
            
            
            
            
            ScrollView {
                
                VStack {
                    
                    
                    HStack {
                        
                        Text("Ai Voice:")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundStyle(.white)
                        
                        
                        Spacer()
                        
                    }
                    
                    
                    HStack(spacing: 20) {
                        
                        HStack {
                            Image("Frame 238")
                                .padding(.top)
                            Text("Male")
                                .font(.custom("Montserrat-Medium", size: 16))
                                .foregroundStyle(.white)
                                .padding(.trailing, 20)
                            
                        }
                        .background(
                            BlurView(style: .systemUltraThinMaterialDark)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        
                        
                        HStack {
                            Image("Frame 237")
                                .padding(.top)
                            Text("Female")
                                .font(.custom("Montserrat-Medium", size: 16))
                                .foregroundStyle(.white)
                                .padding(.trailing, 20)
                            
                        }
                        .background(
                            BlurView(style: .systemUltraThinMaterialDark)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        
                    }
                    .padding(.vertical)
                    
                    
                    HStack {
                        
                        Text("Communication style:")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundStyle(.white)
                        
                        
                        Spacer()
                        
                    }
                    
                    HStack(spacing: 40)  {
                        Button {
                            //
                        } label: {
                            
                            HStack {
                                Image("radio")
                                Text("Formal")
                                    .foregroundStyle(.white)
                            }
                            
                            
                        }
                        
                        
                        Button {
                            //
                        } label: {
                            
                            HStack {
                                Image("Ellipse 5")
                                Text("Informal")
                                    .foregroundStyle(.white)
                            }
                            
                            
                        }
                        
                        
                        Spacer()
                        
                        
                    }
                    .padding(.vertical)
                    
                    
                    
                    HStack {
                        Image("Vector-12")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .padding(.leading, 7)
                        
                        Text("Ukrainian")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding(.vertical, 25)
                        
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background {
                        BlurView(style: .systemUltraThinMaterialDark)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.bottom)
                    
                    
                    
                    
                    HStack {
                        
                        Text("Notifications:")
                            .font(.custom("Montserrat-Light", size: 16))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.white)
                        
                        
                        Toggle("", isOn: $NotificationsIsOn)
                            .tint(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                          Color(Color(hex: "#38A9CF") ?? .blue)],
                                                 startPoint: .leading,
                                                 endPoint: .trailing))
                    }
                    
                    
                    Image("Group 19647")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                    
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Restore purchases")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Share app")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Other apps")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Contact / Feedback")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Privacy Policy")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Terms of Use")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .padding(.top, 130)
            .padding(.bottom, 90)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
}
