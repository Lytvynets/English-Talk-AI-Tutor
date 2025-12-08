//
//  OnboardingPaywall.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

struct OnboardingPaywall: View {
    
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
                        .font(.custom("Montserrat-Bold", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                    
                    Text("Unlock unlimited AI conversations, themed lessons, and smart learning tools.  Make daily practice a part of your life.")
                        .font(.custom("Montserrat-Light", size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                    
                    
                    Text("$7,99 per week")
                        .font(.custom("Montserrat-Bold", size: 18))
                        .foregroundStyle(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                                 Color(Color(hex: "#38A9CF") ?? .blue)],
                                                        startPoint: .leading,
                                                        endPoint: .trailing))
                        .padding(.top, 5)
                        .padding(.bottom)
                    
                    HStack {
                        
                        Text("Enable 7 days Free Trial")
                            .font(.custom("Montserrat-Light", size: 15))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.white)
                        
                        
                        Toggle("", isOn: $trialIsOn)
                            .tint(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                          Color(Color(hex: "#38A9CF") ?? .blue)],
                                                 startPoint: .leading,
                                                 endPoint: .trailing))
                    }
                    .padding(.bottom)
                    
                    Button {
                        print("")
                    } label: {
                        
                        VStack {
                            Text("Subscribe for $7,99/week")
                                .font(.custom("Montserrat-Bold", size: 22))
                                .foregroundStyle(.white)
                            
                            Text("Auto renewable. Cancel any time")
                                .font(.custom("Montserrat-Light", size: 14))
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
                    .padding(.bottom, 20)
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
}

#Preview {
    OnboardingPaywall()
        .environmentObject(OnboardingViewModel())
}
