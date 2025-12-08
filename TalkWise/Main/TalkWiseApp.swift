//
//  TalkWiseApp.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 28.07.2025.
//

import SwiftUI

@main
struct TalkWiseApp: App {
    
    @ObservedObject var onboardingViewModel = OnboardingViewModel()
    @ObservedObject var customTabBarObserver = CustomTabBarObserver()
    @ObservedObject var topicViewModel = TopicViewModel()
    @ObservedObject var wordsViewModel = WordsViewModel()
    @ObservedObject var appRouter = AppRouter()
    @ObservedObject var aIChatViewModel = AIChatViewModel()
    
    @State var savedWords: [String] = []
    @State var isActive = false
    
    var body: some Scene {
        
        WindowGroup {
            
            if isActive {
                
                if onboardingViewModel.showOnboarding {
                    
                    OnboardingView()
                        .environmentObject(onboardingViewModel)
                    
                }else {
                    if onboardingViewModel.showPaywall {
                        OnboardingPaywall()
                            .environmentObject(onboardingViewModel)
                        
                    }else {
                        NavigationStack(path: $appRouter.path) {
                            ZStack {
                                
                                switch customTabBarObserver.selectedTab {
                                case .topics:
                                    TopicsView()
                                case .words:
                                    WordsView()  // FreeChatView(savedWords: $savedWords)
                                case .profile:
                                    ProfileView()
                                case .settings:
                                    SettingsView()
                                }
                                
                                VStack {
                                    Spacer()
                                    
                                    CustomTabBar()
                                }
                            }
                            .navigationDestination(for: AppRoute.self) { route in
                                switch route {
                                case .wordDetailView:
                                    WordDetailView()
                                case .testsView:
                                    TestsView()
                                case .learnedWordsView:
                                    LearnedWordsView()
                                case .freeConversationView:
                                    FreeChatView(savedWords: $savedWords)
                                }
                            }
                        }
                        .environmentObject(appRouter)
                        .environmentObject(wordsViewModel)
                        .environmentObject(customTabBarObserver)
                        .environmentObject(topicViewModel)
                        .environmentObject(aIChatViewModel)
                        
                    }
                }
            }else{
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isActive = true
                        }
                    }
            }
        }
    }
}
