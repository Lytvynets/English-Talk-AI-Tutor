//
//  InAppPaywallView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 14.12.2025.
//

import SwiftUI

enum SubsPlan {
    case weekly
    case monthly
    case annually
}


struct InAppPaywallView: View {
    
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurchaseViewModel
    @Environment(\.dismiss) var dismiss
    @State var freeTrial = false
    @State private var subsPlan: SubsPlan = .weekly
    
    var body: some View {
        
        CustomNavigationBar(title: "", imageName: "Vector 28654363", customNavBarState: .withoutBackButton) {
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 75)
            .padding(.trailing)
            
            ScrollView {
                VStack {
                    HStack {
                        Image("gfrtyjyiutgrfed")
                        Text("UNLIMITED ACCESS \nFOR ALL FEATURES")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive24))
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image("ergewfwdwdw")
                                .padding(.bottom)
                            Text("Weekly subscription with/without trial period")
                        }
                        
                        HStack {
                            Image("ergewfwdwdw")
                                .padding(.bottom)
                            Text("Information: unlimited number of messages, word storage")
                        }
                        
                        HStack {
                            Image("ergewfwdwdw")
                                .padding(.bottom)
                            Text("No subscription: 3 messages \nper day")
                        }
                    }
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    .padding(20)
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                            .opacity(0.9)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    HStack {
                        Toggle("Enable 7 days Free Trial", isOn: $freeTrial)
                            .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive17))
                            .onChange(of: freeTrial) { newValue in
                                if newValue {
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.weekly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailWeekly
                                    }
                                    
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.monthly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailMonthly
                                    }
                                    
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.yearly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailYearly
                                    }
                                    
                                }else{
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.freeTrailWeekly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.weekly
                                    }
                                    
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.freeTrailMonthly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.monthly
                                    }
                                    
                                    if inAppPurchaseViewModel.selectedProductId == AppDefaults.freeTrailYearly {
                                        inAppPurchaseViewModel.selectedProductId = AppDefaults.yearly
                                    }
                                    
                                }
                            }
                    }
                    .padding()
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 15) {
                        HStack {
                            Text("Weekly")
                                .font(.custom(subsPlan == .weekly ? "Montserrat-Bold" : "Montserrat-Regular", size: AdaptiveFontSize.adaptive18))
                            
                            Spacer()
                            
                            Text(freeTrial ? inAppPurchaseViewModel.getPrice(productID: AppDefaults.freeTrailWeekly, products: inAppPurchaseViewModel.products) : inAppPurchaseViewModel.getPrice(productID: AppDefaults.weekly, products: inAppPurchaseViewModel.products))
                                .font(.custom(subsPlan == .weekly ? "Montserrat-Bold" : "Montserrat-Regular", size: AdaptiveFontSize.adaptive18))
                        }
                        .padding(20)
                        .background(
                            subsPlan == .weekly ? LinearGradient(colors: [Color(Color(hex: "#DF582B") ?? .blue), Color(Color(hex: "#5325E9") ?? .blue)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color(Color(hex: "#23293A") ?? .blue), Color(Color(hex: "#23293A") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        .onTapGesture {
                            subsPlan = .weekly
                            if freeTrial {
                                inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailWeekly
                            }else{
                                inAppPurchaseViewModel.selectedProductId = AppDefaults.weekly
                            }
                        }
                        
                        HStack {
                            Text("Monthly")
                                .font(.custom(subsPlan == .monthly ? "Montserrat-Bold" : "Montserrat-Regular", size: AdaptiveFontSize.adaptive18))
                            Spacer()
                            
                            Text(freeTrial ? inAppPurchaseViewModel.getPrice(productID: AppDefaults.freeTrailMonthly, products: inAppPurchaseViewModel.products) : inAppPurchaseViewModel.getPrice(productID: AppDefaults.monthly, products: inAppPurchaseViewModel.products))
                                .font(.custom(subsPlan == .monthly ? "Montserrat-Bold" : "Montserrat-Regular", size: AdaptiveFontSize.adaptive18))
                            
                        }
                        .padding(20)
                        .background(
                            subsPlan == .monthly ? LinearGradient(colors: [Color(Color(hex: "#DF582B") ?? .blue), Color(Color(hex: "#5325E9") ?? .blue)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color(Color(hex: "#23293A") ?? .blue), Color(Color(hex: "#23293A") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        .onTapGesture {
                            subsPlan = .monthly
                            if freeTrial {
                                inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailMonthly
                            }else{
                                inAppPurchaseViewModel.selectedProductId = AppDefaults.monthly
                            }
                        }
                        
                        HStack {
                            Text("Annually")
                                .font(.custom(subsPlan == .annually ? "Montserrat-Bold" : "Montserrat-Regular", size: AdaptiveFontSize.adaptive18))
                            Spacer()
                            
                            Text(freeTrial ? inAppPurchaseViewModel.getPrice(productID: AppDefaults.freeTrailYearly, products: inAppPurchaseViewModel.products) : inAppPurchaseViewModel.getPrice(productID: AppDefaults.yearly, products: inAppPurchaseViewModel.products))
                                .font(.custom(subsPlan == .annually ? "Montserrat-Bold" : "Montserrat-Regular", size: AdaptiveFontSize.adaptive18))
                            
                        }
                        .padding(20)
                        .background(
                            subsPlan == .annually ? LinearGradient(colors: [Color(Color(hex: "#DF582B") ?? .blue), Color(Color(hex: "#5325E9") ?? .blue)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color(Color(hex: "#23293A") ?? .blue), Color(Color(hex: "#23293A") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        .onTapGesture {
                            subsPlan = .annually
                            if freeTrial {
                                inAppPurchaseViewModel.selectedProductId = AppDefaults.freeTrailYearly
                            }else{
                                inAppPurchaseViewModel.selectedProductId = AppDefaults.yearly
                            }
                        }
                    }
                    
                    HStack(spacing: 40) {
                        HStack {
                            Image("grtbvredertnytbvrfc")
                            Text("No Payment yet")
                                .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive14))
                            
                        }
                        
                        HStack {
                            Image("htrgfedjuyhgtfrde")
                            Text("Cancel any time")
                                .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive14))
                            
                        }
                    }
                    .padding()
                    
                    Button {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        Task {
                            if let product = inAppPurchaseViewModel.products.first(where: {$0.id == inAppPurchaseViewModel.selectedProductId }) {
                                await inAppPurchaseViewModel.purchase(product) { result in
                                    switch result {
                                    case .success(_):
                                        dismiss()
                                    case .failure(_):
                                        inAppPurchaseViewModel.presentErrorAlert = true
                                    }
                                }
                            }
                        }
                        
                    } label: {
                        Text("CONTINUE")
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Bold", size: 17))
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background {
                                LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                        Color(Color(hex: "#38A9CF") ?? .blue)],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .padding()
                    }
                    
                    
                    HStack {
                        Button {
                            //
                        } label: {
                            Text("Terms of Use")
                                .underline()
                        }.padding(.horizontal, 10)
                        
                        Button {
                            //
                        } label: {
                            Text("Privacy Policy")
                                .underline()
                        }
                        .padding(.horizontal, 10)
                        
                        Button {
                            Task {
                                await inAppPurchaseViewModel.restorePurchases()
                            }
                        } label: {
                            Text("Restore")
                                .underline()
                        }
                        .padding(.horizontal, 10)
                    }
                    .foregroundStyle(Color(hex: "#A3A3A3") ?? .gray)
                    .font(.custom("Montserrat-Regular", size: 11))
                }
                .foregroundStyle(.white)
                
            }
            .padding(.top, 100)
        }
    }
}

#Preview {
    InAppPaywallView()
        .environmentObject(InAppPurchaseViewModel())
}
