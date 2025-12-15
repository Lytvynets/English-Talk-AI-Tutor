//
//  SettingsViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 14.12.2025.
//

import Foundation

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
