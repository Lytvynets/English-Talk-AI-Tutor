//
//  OnboardingView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI
import StoreKit

struct OnboardingView: View {
    
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
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
                Image(onboardingViewModel.onboardingItems[onboardingViewModel.currentItem].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, onboardingViewModel.onboardingItems[onboardingViewModel.currentItem].spacing)
                    .padding(.horizontal, onboardingViewModel.currentItem == 0 ? 19 : 0)
                    .padding(.leading, onboardingViewModel.currentItem == 1 ? 10 : 0)
                    .padding(.horizontal, onboardingViewModel.currentItem == 2 ? 10 : 0)
                Spacer()
            }
            
            VStack {
                Spacer()
                VStack {
                    Text(onboardingViewModel.onboardingItems[onboardingViewModel.currentItem].title)
                        .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive22))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(.vertical)
                    
                    Text(onboardingViewModel.onboardingItems[onboardingViewModel.currentItem].subtitle)
                        .font(.custom("Montserrat-Light", size: AdaptiveFontSize.adaptive14))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(.bottom)
                    
                    DiamondPageControl(numberOfPages: 5, currentPage: $onboardingViewModel.currentItem)
                        .padding(.bottom)
                    
                    Button {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        if onboardingViewModel.currentItem < onboardingViewModel.onboardingItems.count - 1 {
                            onboardingViewModel.currentItem += 1
                        }else {
                            onboardingViewModel.showOnboarding = false
                            onboardingViewModel.showPaywall = true
                        }
                        
                        if onboardingViewModel.currentItem == 2 {
                            requestAppStoreReview()
                        }
                    } label: {
                        Text("CONTINUE")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive22))
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
                    .padding(.bottom, 25)
                }
                .padding()
                .background(
                    BlurView(style: .systemUltraThinMaterialDark)
                        .opacity(1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
        .ignoresSafeArea()
    }
    
    
    private func requestAppStoreReview() {
        guard let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
        else { return }
        
        SKStoreReviewController.requestReview(in: scene)
    }
}


#Preview {
    OnboardingView()
        .environmentObject(OnboardingViewModel())
}
