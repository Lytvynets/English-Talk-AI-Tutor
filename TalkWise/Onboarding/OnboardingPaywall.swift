//
//  OnboardingPaywall.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

struct OnboardingPaywall: View {
    
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurchaseViewModel
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @State var trialIsOn = false
    
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
                Image("Mask group")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 60)
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        onboardingViewModel.showPaywall = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .padding(.top, 60)
            .padding(.trailing)
            
            VStack {
                Spacer()
                VStack {
                    Text("Unlock your best English yet")
                        .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive22))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(.vertical)
                    
                    Text("Unlock unlimited AI conversations, themed \nlessons, and smart learning tools. \nMake daily practice a part of your life.")
                        .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive14))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                    
                    Text("\(trialIsOn ? inAppPurchaseViewModel.getPrice(productID: AppDefaults.freeTrailWeekly, products: inAppPurchaseViewModel.products) : inAppPurchaseViewModel.getPrice(productID: AppDefaults.weekly, products: inAppPurchaseViewModel.products)) per week")
                        .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive18))
                        .foregroundStyle(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                                 Color(Color(hex: "#38A9CF") ?? .blue)],
                                                        startPoint: .leading,
                                                        endPoint: .trailing))
                        .padding(.top, 5)
                        .padding(.bottom)
                    
                    HStack {
                        Toggle("Enable 7 days Free Trial", isOn: $trialIsOn)
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive17))
                            .tint(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                          Color(Color(hex: "#38A9CF") ?? .blue)],
                                                 startPoint: .leading,
                                                 endPoint: .trailing))
                            .onChange(of: trialIsOn) { newValue in
                                if newValue {
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.weekly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailWeekly
                                    }
                                }else{
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.freeTrailWeekly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.weekly
                                    }
                                }
                            }
                    }
                    .padding(.bottom)
                    
                    Button {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        Task {
                            if let product = inAppPurchaseViewModel.products.first(where: {$0.id == inAppPurchaseViewModel.selectedProductId }) {
                                await inAppPurchaseViewModel.purchase(product) { result in
                                    switch result {
                                    case .success(_):
                                        onboardingViewModel.showPaywall = false
                                    case .failure(_):
                                        inAppPurchaseViewModel.presentErrorAlert = true
                                    }
                                }
                            }
                        }
                    } label: {
                        VStack(spacing: 2) {
                            Text("SUBSCRIBE FOR \(trialIsOn ? inAppPurchaseViewModel.getPrice(productID: AppDefaults.freeTrailWeekly, products: inAppPurchaseViewModel.products) : inAppPurchaseViewModel.getPrice(productID: AppDefaults.weekly, products: inAppPurchaseViewModel.products))/week")
                                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                                .foregroundStyle(.white)
                            
                            Text("Auto renewable. Cancel any time")
                                .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive12))
                                .foregroundStyle(.white)
                        }
                        .padding()
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
                        .opacity(0.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
        .ignoresSafeArea()
    }
}


#Preview {
    OnboardingPaywall()
        .environmentObject(OnboardingViewModel())
        .environmentObject(InAppPurchaseViewModel())
}
