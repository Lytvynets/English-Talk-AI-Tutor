//
//  TalkWiseApp.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 28.07.2025.
//

import SwiftUI
import Firebase


@main
struct TalkWiseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @ObservedObject var onboardingViewModel = OnboardingViewModel()
    @ObservedObject var customTabBarObserver = CustomTabBarObserver()
    @StateObject var topicViewModel: TopicViewModel
    @ObservedObject var wordsViewModel = WordsViewModel()
    @ObservedObject var appRouter = AppRouter()
    @ObservedObject var aIChatViewModel = AIChatViewModel()
    @ObservedObject var authorizationViewModel = AuthorizationViewModel()
    @ObservedObject var testViewModel = TestViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    @ObservedObject var simpleTimerViewModel = SimpleTimerViewModel()
    @ObservedObject var inAppPurchaseViewModel = InAppPurchaseViewModel()
    @ObservedObject var dailyTapCounter = DailyTapCounter()
    
    @State var savedWords: [String] = []
    @State var isActive = false
    
    init() {
        let settingsVM = SettingsViewModel()
        _settingsViewModel = StateObject(wrappedValue: settingsVM)
        _topicViewModel = StateObject(
            wrappedValue: TopicViewModel(settings: settingsVM)
        )
    }
    
    
    var body: some Scene {
        
        WindowGroup {
            if isActive {
                if onboardingViewModel.showOnboarding {
                    OnboardingView()
                        .environmentObject(onboardingViewModel)
                        .environmentObject(inAppPurchaseViewModel)
                        .onAppear {
                            UserDefaults.standard.set(true, forKey: "didSeeOnboarding")

                            @AppStorage("dailyNotificationsEnabled")
                            var notificationsEnabled: Bool = true
                            
                            if notificationsEnabled {
                                NotificationManager.shared.requestPermission()
                                NotificationManager.shared.scheduleDailyNotification()
                            }
                        }
                }else {
                    if onboardingViewModel.showPaywall {
                        OnboardingPaywall()
                            .environmentObject(onboardingViewModel)
                            .environmentObject(inAppPurchaseViewModel)
                            .onDisappear {
                                Task {
                                    for sub in inAppPurchaseViewModel.products {
                                        inAppPurchaseViewModel.isSubscribed = await inAppPurchaseViewModel.checkSubscriptionStatus(for: sub.id)
                                    }
                                }
                            }
                    }else {
                        NavigationStack(path: $appRouter.path) {
                            ZStack {
                                switch customTabBarObserver.selectedTab {
                                case .topics:
                                    TopicsView()
                                case .words:
                                    WordsView()
                                case .profile:
                                    ProfileView()
                                case .settings:
                                    SettingsView()
                                }
                                
                                VStack {
                                    Spacer()
                                    CustomTabBar()
                                }
                                
                                if authorizationViewModel.showAuthorizationView {
                                    AuthorizationView()
                                        .onDisappear {
                                            let didSeeTranslateLanguageView = UserDefaults.standard.bool(forKey: "TranslateLanguageView")
                                            if !didSeeTranslateLanguageView {
                                                settingsViewModel.showTranslateLanguageView = true
                                            }
                                        }
                                }
                            }
                            .sheet(isPresented: $settingsViewModel.showTranslateLanguageView) {
                                TranslateLanguageView()
                                    .onAppear {
                                        UserDefaults.standard.set(true, forKey: "TranslateLanguageView")
                                    }
                            }
                            .fullScreenCover(isPresented: $settingsViewModel.showPaywall) {
                                InAppPaywallView()
                                    .onDisappear {
                                        Task {
                                            for sub in inAppPurchaseViewModel.products {
                                                inAppPurchaseViewModel.isSubscribed = await inAppPurchaseViewModel.checkSubscriptionStatus(for: sub.id)
                                            }
                                        }
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
                        .environmentObject(authorizationViewModel)
                        .environmentObject(testViewModel)
                        .environmentObject(settingsViewModel)
                        .environmentObject(simpleTimerViewModel)
                        .environmentObject(inAppPurchaseViewModel)
                        .environmentObject(dailyTapCounter)
                        .environmentObject(onboardingViewModel)
                    }
                }
            }else{
                LoadingView()
                    .onAppear {
                        let didSeeOnboarding = UserDefaults.standard.bool(forKey: "didSeeOnboarding")
                        if didSeeOnboarding {
                            onboardingViewModel.showOnboarding = false
                        }
                        Task {
                            await inAppPurchaseViewModel.fetchProducts()
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isActive = true
                            
                            Task {
                                for sub in inAppPurchaseViewModel.products {
                                    inAppPurchaseViewModel.isSubscribed = await inAppPurchaseViewModel.checkSubscriptionStatus(for: sub.id)
                                }
                                
                                let didSeeOnboarding = UserDefaults.standard.bool(forKey: "didSeeOnboarding")
                                if didSeeOnboarding {
                                    if !inAppPurchaseViewModel.isSubscribed {
                                        withAnimation(.easeInOut) {
                                            onboardingViewModel.showPaywall = true
                                        }
                                       
                                    }
                                }
                            }
                            
                            if authorizationViewModel.isUserLoggedIn() {
                                authorizationViewModel.showAuthorizationView = false
                            }
                        }
                    }
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
