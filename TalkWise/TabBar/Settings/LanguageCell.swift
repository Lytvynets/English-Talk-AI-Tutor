//
//  LanguageCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 13.12.2025.
//

import SwiftUI

struct LanguageCell: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var language: String
    
    var body: some View {
        HStack {
            Image(settingsViewModel.selectedLanguages == language ? "radio" : "Ellipse 5")
            Text(language)
                .foregroundStyle(.white)
                .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
            Spacer()
        }
        .padding(13)
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color(hex: "#313A4F") ?? .gray)
        }
        .onTapGesture {
            settingsViewModel.selectedLanguages = language
            UserDefaults.standard.set(language, forKey: "selectedLanguages")
            settingsViewModel.showTranslateLanguageView = false
        }
       
    }
}

#Preview {
    LanguageCell(language: "language")
}
