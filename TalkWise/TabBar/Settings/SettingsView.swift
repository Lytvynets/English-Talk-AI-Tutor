//
//  SettingsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.08.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurchaseViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var topicViewModel: TopicViewModel
    @AppStorage("dailyNotificationsEnabled")
    private var notificationsEnabled: Bool = true
    @Environment(\.openURL) var openEmail
    @State private var showShareSheet = false
    
    
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
                    
                    Text("Settings")
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
                        Text("Ai Voice:")
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        HStack {
                            Image("Frame 238")
                                .padding(.top)
                            Text("Male")
                                .padding(.trailing, 20)
                        }
                        .background(
                            settingsViewModel.selectedVoice == .male ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F80") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        .onTapGesture {
                            settingsViewModel.selectedVoice = .male
                        }
                        
                        HStack {
                            Image("Frame 237")
                                .padding(.top)
                            Text("Female")
                                .padding(.trailing, 20)
                        }
                        .background(
                            settingsViewModel.selectedVoice == .female ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F80") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        .onTapGesture {
                            settingsViewModel.selectedVoice = .female
                        }
                    }
                    .foregroundStyle(.white)
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    .padding(.vertical)
                    
                    HStack {
                        Text("Communication style:")
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    HStack(spacing: 40)  {
                        Button {
                            settingsViewModel.communication = .formal
                            topicViewModel.updateTopics()
                        } label: {
                            HStack {
                                Image(settingsViewModel.communication == .formal ? "radio" : "Ellipse 5")
                                Text("Formal")
                            }
                        }
                        
                        Button {
                            settingsViewModel.communication = .informal
                            topicViewModel.updateTopics()
                        } label: {
                            HStack {
                                Image(settingsViewModel.communication == .informal ? "radio" : "Ellipse 5")
                                Text("Informal")
                            }
                        }
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    .padding(.vertical)
                    
                    HStack {
                        Image("Vector-12")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .padding(.leading, 7)
                        
                        Text(settingsViewModel.selectedLanguages)
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding(.vertical, 25)
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background {
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.bottom)
                    .onTapGesture {
                        settingsViewModel.showTranslateLanguageView = true
                    }
                    
                    HStack {
                        Toggle("Notifications:", isOn: $notificationsEnabled)
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                            .tint(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                          Color(Color(hex: "#38A9CF") ?? .blue)],
                                                 startPoint: .leading,
                                                 endPoint: .trailing))
                            .onChange(of: notificationsEnabled) { isOn in
                                if isOn {
                                    NotificationManager.shared.requestPermission()
                                    NotificationManager.shared.scheduleDailyNotification()
                                } else {
                                    NotificationManager.shared.disableNotifications()
                                }
                            }
                    }
                    
                    Image("Group 19647")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                        .onTapGesture {
                            settingsViewModel.showPaywall = true
                        }
                    
                    HStack {
                        Image("ix_restore")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Restore purchases")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    .onTapGesture {
                        Task {
                            await inAppPurchaseViewModel.restorePurchases()
                        }
                    }
                    
                    HStack {
                        Image("tdesign_share-filled")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Share app")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    .onTapGesture {
                        showShareSheet = true
                    }
                    
                    HStack {
                        Image("tdesign_app-filled")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Other apps")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    .onTapGesture {
                        openURL(AppDefaults.otherAppsUrl)
                    }
                    
                    
                    HStack {
                        Image("ri_message-2-fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Contact / Feedback")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                        
                    }
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    .onTapGesture {
                        let subject = ""
                        let body = ""
                        if let url = URL(string: "mailto:\(AppDefaults.email)?subject=\(subject)&body=\(body)") {
                            openEmail(url)
                        }
                    }
                    
                    HStack {
                        Image("material-symbols_privacy-tip-rounded")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Privacy Policy")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    .onTapGesture {
                        openURL(AppDefaults.privacyPolicyURL)
                    }
                    
                    
                    HStack {
                        Image("lsicon_list-filled")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(.leading)
                        
                        Text("Terms of Use")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background(
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical, 3)
                    .onTapGesture {
                        openURL(AppDefaults.termsOfUseURL)
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .padding(.top, 130)
            .padding(.bottom, 90)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showShareSheet, content: {
            if let url = URL(string: AppDefaults.appURL) {
                ShareSheetURL(activityItems: [url])
            }
        })
    }
    
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}


#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
