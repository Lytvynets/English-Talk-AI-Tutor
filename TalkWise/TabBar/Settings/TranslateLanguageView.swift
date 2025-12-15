//
//  TranslateLanguageView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 13.12.2025.
//

import SwiftUI

struct TranslateLanguageView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        
        ZStack {
            Color(hex: "#232A3A")
                .ignoresSafeArea()
            
            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 63, height: 6)
                    .foregroundStyle(Color(hex: "#BBBBBB") ?? .gray)
                
                Text("Translate to:")
                    .foregroundStyle(.white)
                    .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive19))
                    .padding(.top, 10)
                
                ScrollView {
                    ForEach(settingsViewModel.Languages, id: \.self) { language in
                        LanguageCell(language: language)
                            .padding(.vertical, 5)
                    }
                }
                .scrollIndicators(.hidden)
                Spacer()
            }
            .padding(10)
            .padding(.top)
        }
    }
}

#Preview {
    TranslateLanguageView()
        .environmentObject(SettingsViewModel())
}
