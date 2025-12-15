//
//  ProfileView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var authorizationViewModel: AuthorizationViewModel
    @EnvironmentObject var topicViewModel: TopicViewModel
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @EnvironmentObject var dailyTapCounter: DailyTapCounter
    
    @State private var showAlertLogout = false
    @State private var showAlertDeleteAccount = false
    
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
                    Text("Profile")
                        .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive23))
                        .foregroundStyle(.white)
                    Spacer()
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
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    HStack {
                        Image("prof")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        if let email = Auth.auth().currentUser?.email {
                            Text(email)
                                .padding(.vertical)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color(hex: "#3D4353") ?? .gray)
                    )
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .padding(.top, 5)
                    .padding(.bottom, 50)
                    
                    HStack {
                        Text("Current level:")
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    HStack(spacing: 40)  {
                        Button {
                            settingsViewModel.currentLevel = .beginner
                            topicViewModel.updateTopics()
                        } label: {
                            
                            HStack {
                                Image(settingsViewModel.currentLevel == .beginner ? "radio" : "Ellipse 5")
                                Text("Beginner")
                            }
                        }
                        
                        Button {
                            settingsViewModel.currentLevel = .intermediate
                            topicViewModel.updateTopics()
                        } label: {
                            HStack {
                                Image(settingsViewModel.currentLevel == .intermediate ? "radio" : "Ellipse 5")
                                Text("Intermediate")
                            }
                        }
                        
                        Spacer()
                    }
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                    
                    HStack {
                        Text("Purpose:")
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.top)
                    
                    HStack(spacing: 40) {
                        Button {
                            settingsViewModel.purpose = .travel
                            topicViewModel.updateTopics()
                        } label: {
                            HStack {
                                Image(settingsViewModel.purpose == .travel ? "radio" : "Ellipse 5")
                                Text("Travel")
                            }
                        }
                        
                        Button {
                            settingsViewModel.purpose = .work
                            topicViewModel.updateTopics()
                        } label: {
                            
                            HStack {
                                Image(settingsViewModel.purpose == .work ? "radio" : "Ellipse 5")
                                Text("Work")
                            }
                        }
                        
                        Button {
                            settingsViewModel.purpose = .study
                            topicViewModel.updateTopics()
                        } label: {
                            HStack {
                                Image(settingsViewModel.purpose == .study ? "radio" : "Ellipse 5")
                                Text("Study")
                            }
                        }
                        
                        Spacer()
                    }
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                    
                    HStack {
                        Image("Vector264345353")
                        Text("Learned words")
                            .padding(.leading, 7)
                        
                        Spacer()
                        
                        Text("\(wordsViewModel.learnedWords.count)")
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
                    .foregroundStyle(.white)
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    .padding(.trailing, 10)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        appRouter.goTo(.learnedWordsView)
                    }
                    
                    HStack {
                        Image("Vector 167098623")
                        Text("Available messages")
                            .padding(.leading, 7)
                        
                        Spacer()
                        
                        Text("\(dailyTapCounter.tapsToday)/3")
                            .font(.custom("Montserrat-SemiBold", size: 15))
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
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    .foregroundStyle(.white)
                    .padding(.trailing, 10)
                    .padding(.bottom)
                    
                    Button {
                        showAlertLogout = true
                    } label: {
                        Text("Log out")
                            .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive18))
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
                        showAlertDeleteAccount = true
                    } label: {
                        Text("Delete account")
                            .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive18))
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
            .padding(.bottom, 100)
            .scrollIndicators(.hidden)
            
            if showAlertDeleteAccount {
                BlurView(style: .systemUltraThinMaterialDark)
                    .ignoresSafeArea()
                
                CustomAlert(textAlert: "Are you sure you want to Delete account?") {
                    Task {
                        try await authorizationViewModel.deleteUserDocument()
                        try authorizationViewModel.signOut()
                        authorizationViewModel.showAuthorizationView = true
                        
                    }
                } noButton: {
                    showAlertDeleteAccount = false
                }
            }
            
            
            if showAlertLogout {
                BlurView(style: .systemUltraThinMaterialDark)
                    .ignoresSafeArea()
                
                CustomAlert(textAlert: "Are you sure you want to log out?") {
                    Task {
                        try authorizationViewModel.signOut()
                        authorizationViewModel.showAuthorizationView = true
                    }
                } noButton: {
                    showAlertLogout = false
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            wordsViewModel.fetchLearnedWords()
        }
    }
}


#Preview {
    @Previewable @StateObject var settingsViewModel = SettingsViewModel()
    ProfileView()
        .environmentObject(SettingsViewModel())
        .environmentObject(AppRouter())
        .environmentObject(AuthorizationViewModel())
        .environmentObject(TopicViewModel(settings: settingsViewModel))
        .environmentObject(WordsViewModel())
}
