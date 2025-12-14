//
//  SettingsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.08.2025.
//

import SwiftUI


enum VoiceType: String, CaseIterable {
    case female = "nova"
    case male = "alloy"
}

enum Communication: String, CaseIterable {
    case formal = "Formal"
    case informal = "Informal"
}


enum CurrentLevel: String, CaseIterable {
    case beginner = "Communicate in simple words and not long phrases like level A0"
    case intermediate = "Communicate like an intermediate level but still not in long sentences"
}

enum Purpose: String, CaseIterable {
    case travel = "travel"
    case work = "work"
    case study = "study"
}



class SettingsViewModel: ObservableObject {
    
    @Published var Languages: [String] = ["German", "Spanish", "Chinese",
                                          "Hindi", "Arabic", "Ukrainian",
                                          "Portuguese", "French", "Italian",
                                          "Polish", "Turkish", "Russian",
                                          "Chinese", "Japanese", "Korean"]
    
    @Published var selectedLanguages = "Ukrainian"
    @Published var showTranslateLanguageView = false
    @Published var showPaywall = false
    
    static var communicationStyle = UserDefaults.standard.string(forKey: "communicationStyle") ?? "Formal"
    static var currentLevel = UserDefaults.standard.string(forKey: "currentLevel") ?? "Communicate in simple words and not long phrases like level A0"

    
    @Published var selectedVoice: VoiceType {
        didSet {
            UserDefaults.standard.set(selectedVoice.rawValue, forKey: "selectedVoice")
        }
    }
    
    @Published var communication: Communication {
        didSet {
            UserDefaults.standard.set(communication.rawValue, forKey: "communicationStyle")
        }
    }
    
    @Published var currentLevel: CurrentLevel {
        didSet {
            UserDefaults.standard.set(currentLevel.rawValue, forKey: "currentLevel")
        }
    }
    
    
    @Published var purpose: Purpose {
        didSet {
            UserDefaults.standard.set(currentLevel.rawValue, forKey: "purpose")
        }
    }
    
    
    
    init() {
        let savedVoice = UserDefaults.standard.string(forKey: "selectedVoice")
        let communication = UserDefaults.standard.string(forKey: "communicationStyle")
        let selectedLanguages = UserDefaults.standard.string(forKey: "selectedLanguages") ?? "Ukrainian"
        let currentLevel = UserDefaults.standard.string(forKey: "currentLevel")
        let purpose = UserDefaults.standard.string(forKey: "purpose")
   
        self.selectedLanguages = selectedLanguages
        self.selectedVoice = VoiceType(rawValue: savedVoice ?? "") ?? .female
        self.communication = Communication(rawValue: communication ?? "") ?? .formal
        self.currentLevel = CurrentLevel(rawValue: currentLevel ?? "") ?? .beginner
        self.purpose = Purpose(rawValue: purpose ?? "") ?? .travel
    }
}


struct SettingsView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var topicViewModel: TopicViewModel
    @AppStorage("dailyNotificationsEnabled")
    private var notificationsEnabled: Bool = true
    
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
                        .font(.custom("Montserrat-Bold", size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
//                    Button {
//                        print("")
//                    } label: {
//                        Text("Save")
//                            .font(.custom("Montserrat-Medium", size: 17))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.horizontal)
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
                                .font(.custom("Montserrat-Medium", size: 16))
                                .foregroundStyle(.white)
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
                    .padding(.vertical)
                    
                    
                    HStack {
                        
                        Text("Communication style:")
                            .font(.custom("Montserrat-Medium", size: 16))
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
                                    .foregroundStyle(.white)
                            }
                            
                            
                        }
                        
                        
                        Button {
                            settingsViewModel.communication = .informal
                            topicViewModel.updateTopics()
                        } label: {
                            
                            HStack {
                                Image(settingsViewModel.communication == .informal ? "radio" : "Ellipse 5")
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
                        
                        Text(settingsViewModel.selectedLanguages)
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundStyle(.white)
                            .padding(.vertical, 25)
                        
                        
                        Spacer()
                        
                        Image("Vector 13452342")
                            .padding()
                    }
                    .background {
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                       // BlurView(style: .systemUltraThinMaterialDark)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.bottom)
                    .onTapGesture {
                        settingsViewModel.showTranslateLanguageView = true
                    }
                    
                    
                    
                    
                    
                    HStack {
                        
//                        Text("Notifications:")
//                            .font(.custom("Montserrat-Light", size: 16))
//                            .multilineTextAlignment(.leading)
//                            .foregroundStyle(.white)
                        
                        
                        Toggle("Notifications:", isOn: $notificationsEnabled)
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Light", size: 16))
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
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                      //  BlurView(style: .systemUltraThinMaterialDark)
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
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                       // BlurView(style: .systemUltraThinMaterialDark)
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
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                       // BlurView(style: .systemUltraThinMaterialDark)
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
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                       // BlurView(style: .systemUltraThinMaterialDark)
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
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                       // BlurView(style: .systemUltraThinMaterialDark)
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
                        LinearGradient(colors: [Color(Color(hex: "#262D3F") ?? .blue), Color(Color(hex: "#262D3F") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                       // BlurView(style: .systemUltraThinMaterialDark)
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
        .environmentObject(SettingsViewModel())
}



final class SimpleTimerViewModel: ObservableObject {

    @Published var seconds: Int = 0
    @Published var isRunning = false

    private var timer: Timer?

    var timeString: String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func start() {
        guard !isRunning else { return }
        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.seconds += 1
        }
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func toggle() {
        isRunning ? stop() : start()
    }

    func reset() {
        stop()
        seconds = 0
    }
}
