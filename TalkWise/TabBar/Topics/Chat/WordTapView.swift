//
//  WordTapView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 09.12.2025.
//

import SwiftUI

struct WordTapView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var viewModel: AIChatViewModel
    let text: String
    @Binding var savedWords: [String]
    @State var messageIndex: Int
    
    var body: some View {
        let cleanedText = text
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let words = cleanedText.split(separator: " ").map(String.init)
        
        return VStack(alignment: .leading) {
            Wrap(words, spacing: 1) { word in
                Text(verbatim: word)
                    .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                    .foregroundStyle(.white)
                    .cornerRadius(6)
                    .onTapGesture {
                        withAnimation {
                            viewModel.translateOnlyWord = true
                            viewModel.showTranslateWord = true
                            viewModel.translateWord = "\(word)"
                            viewModel.translatedWord = ""
                            viewModel.highlightedMessageIndex = messageIndex
                            
                            OpenAITranslator.translate(text: viewModel.translateWord, to: settingsViewModel.selectedLanguages) {
                                translatedText in
                                DispatchQueue.main.async {
                                    viewModel.translatedWord = translatedText ?? ""
                                }
                                print(translatedText ?? "Помилка перекладу")
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var savedWords: [String] = ["Test", "Test"]
    WordTapView(text: "Test", savedWords: $savedWords, messageIndex: 0)
}
