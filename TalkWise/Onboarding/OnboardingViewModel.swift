//
//  OnboardingViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 12.08.2025.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    @Published var showOnboarding = true
    @Published var showPaywall = false
    @Published var currentItem = 0
    @Published var onboardingItems: [OnboardingItemModel] = [OnboardingItemModel(title: "Choose topics you love",
                                                                                 subtitle: "Explore fun and useful conversations on daily \nlife, travel, and work. Learn vocabulary in \ncontext you care about.",
                                                                                 imageName: "Group 19649",
                                                                                 spacing: 60),
                                                             OnboardingItemModel(title: "Chat with AI, anytime",
                                                                                 subtitle: "Practice speaking naturally with your personal \nAI tutor. Enjoy real voice conversations \nwhenever you want.",
                                                                                 imageName: "Group 1000003583",
                                                                                 spacing: 99),
                                                             OnboardingItemModel(title: "Learn words, remember fast",
                                                                                 subtitle: "Master new vocabulary with smart flashcards \nand pronunciation help. Keep your learning \nsimple and effective.",
                                                                                 imageName: "Group 19640",
                                                                                 spacing: 60),
                                                             OnboardingItemModel(title: "Explore your path to fluency",
                                                                                 subtitle: "Access unlimited AI conversations, themed \ndialogues, and smart flashcards and tests. \nLearn every day and see your skills grow.",
                                                                                 imageName: "Group 19657",
                                                                                 spacing: 75)]
    
    
    
}
