//
//  LoadingView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var showImage = false
    @State private var showTitle = false
    @State private var showSubtitle = false

    
    var body: some View {
        
        ZStack {
            
            Color(hex: "#212737")
                .ignoresSafeArea()
            
            VStack {
                Image("launchicon")
                    .resizable()
                    .frame(width: 112, height: 112)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scaleEffect(showImage ? 1 : 0.7)
                    .opacity(showImage ? 1 : 0)
                    .padding(.bottom)
                    .animation(.spring(response: 1, dampingFraction: 1), value: showImage)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showTitle = true
                        }
                    }
                
                
                
                if showTitle {
                    TypewriterText(text: "English Talk AI Tutor")
                        .font(.custom("Montserrat-Bold", size: 25))
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                showSubtitle = true
                            }
                        }
                }else{
                    Text("  ")
                        .font(.custom("Montserrat-Bold", size: 25))
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                }
                 
                
                Text("Your AI speaking partner")
                    .font(.custom("Montserrat-Light", size: 16))
                    .opacity(showSubtitle ? 1 : 0)
                        .animation(.easeOut(duration: 0.6), value: showSubtitle)
                        .foregroundStyle(.white)
         
            }
            .padding(.bottom, 50)
            
            
            VStack {
                
                Spacer()
                
                Image("Vector 1")
                    .resizable()
                    .frame(height: 200)
                
                
            }
            .ignoresSafeArea()
            
        }
        .onAppear {
            showImage = true
          }
    }
}

#Preview {
    LoadingView()
}



struct TypewriterText: View {
    let text: String
    @State private var visibleText = ""
    private let haptic = UIImpactFeedbackGenerator(style: .medium)

    
    var body: some View {
        Text(visibleText)
            .onAppear {
                visibleText = ""
                haptic.prepare()
                for (index, char) in text.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                        visibleText.append(char)
                        haptic.impactOccurred(intensity: 0.3)
                    }
                }
            }
    }
}
