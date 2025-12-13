//
//  ProfileView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var authorizationViewModel: AuthorizationViewModel

    
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
                    
                    Text("Profile")
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
                    
                    Text("Email:")
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundStyle(.white)
                    
                    
                    Spacer()
                    
                }
                
                
                HStack {
                    Image("prof")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                        .padding(.leading)
                    
                    Text("vlad@gmail.com")
                        .padding(.vertical)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    
                }
                .background(
                    Color(hex: "#3D4353")
                        .opacity(0.2)
                    
                )
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.white)
                )
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .padding(.bottom, 50)
                
                
                
                HStack {
                    
                    Text("Current level:")
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
                            Text("Beginner")
                                .foregroundStyle(.white)
                        }
                        
                        
                    }
                    
                    
                    Button {
                        //
                    } label: {
                        
                        HStack {
                            Image("Ellipse 5")
                            Text("Intermediate")
                                .foregroundStyle(.white)
                        }
                        
                        
                    }
                    
                    
                    Spacer()
                    
                    
                }
                .padding(.bottom, 30)
                
                
                
                HStack {
                    
                    Text("Purpose:")
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundStyle(.white)
                    
                    
                    Spacer()
                    
                }
                .padding(.top)
                
                HStack(spacing: 40) {
                    Button {
                        //
                    } label: {
                        
                        HStack {
                            Image("radio")
                            Text("Travel")
                                .foregroundStyle(.white)
                        }
                        
                        
                    }
                    
                    
                    Button {
                        //
                    } label: {
                        
                        HStack {
                            Image("Ellipse 5")
                            Text("Work")
                                .foregroundStyle(.white)
                        }
                        
                        
                    }
                    
                    
                    Button {
                        //
                    } label: {
                        
                        HStack {
                            Image("Ellipse 5")
                            Text("Study")
                                .foregroundStyle(.white)
                        }
                        
                        
                    }
                    
                    
                    
                    Spacer()
                    
                    
                }
                .padding(.bottom, 30)
                
                
                
                HStack {
                    Image("solar_dialog-bold")
                    
                    Text("Completed dialogs")
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundStyle(.white)
                    
                    
                    Spacer()
                    
                    Text("3")
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 10)
                        .background {
                            LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                    Color(Color(hex: "#38A9CF") ?? .blue)],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                }
                .padding(.trailing, 10)
                .padding(.bottom)
                
                
                
                HStack {
                    Image("Vector264345353")
                    
                    Text("Learned words")
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundStyle(.white)
                    
                    
                    Spacer()
                    
                    Text("130")
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 10)
                        .background {
                            LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                    Color(Color(hex: "#38A9CF") ?? .blue)],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                }
                .padding(.trailing, 10)
                .padding(.bottom, 50)
                .onTapGesture {
                    appRouter.goTo(.learnedWordsView)
                }
                
                
                HStack {
                    
                    Image("Vector 167098623")
                    //  .padding(.leading, 5)
                    
                    Text("Available messages")
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundStyle(.white)
                        .padding(.leading, 7)
                    
                    Spacer()
                    
                    Text("3/3")
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 10)
                        .background {
                            LinearGradient(colors: [Color(Color(hex: "#24AF5C") ?? .blue),
                                                    Color(Color(hex: "#14A9A4") ?? .blue)],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                }
                .padding(.trailing, 10)
                
                
                Button {
                    Task {
                       try authorizationViewModel.signOut()
                        authorizationViewModel.showAuthorizationView = true
                    }
                } label: {
                    Text("Log out")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.white)
                        )
                }
                .padding(.vertical)
                
                
                Button {
                    //
                } label: {
                    Text("Delete account")
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.red)
                        )
                }
                
                
            }.padding()
            
            
        }
        .padding(.top, 100)
        .padding(.bottom, 75)
        .scrollIndicators(.hidden)
            
        }
        .ignoresSafeArea()
            
    }
}

#Preview {
    ProfileView()
}
