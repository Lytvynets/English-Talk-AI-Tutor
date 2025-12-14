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
    
    var body: some View {
        let words = text.split(separator: " ").map(String.init)
        
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
                       /*     OpenAITranslator.translate(text: viewModel.translateWord, to: "ukrainian") {*/
                            OpenAITranslator.translate(text: viewModel.translateWord, to: settingsViewModel.selectedLanguages) {
                            translatedText in
                                DispatchQueue.main.async {
                                    viewModel.translatedWord = translatedText ?? ""
                                }
                                print(translatedText ?? "Помилка перекладу")
                            }
                            
//                            DispatchQueue.main.async {
//                                Translator.translate(text: viewModel.translateWord, to: "uk") { word in
//                                    print("Word \(viewModel.translateWord) - \(String(describing: word))")
//                                    DispatchQueue.main.async {
//                                        viewModel.translatedWord = word ?? ""
//                                    }
//                                }
//                            }
                         
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var savedWords: [String] = ["Test", "Test"]
    WordTapView(text: "Test", savedWords: $savedWords)
}
