//
//  WordDetailView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 07.12.2025.
//

import SwiftUI
import Kingfisher

struct WordDetailView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var aIChatViewModel: AIChatViewModel
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurchaseViewModel
    
    @State var imageURL: URL?
    @State var example = ""
    @State var transcription = ""
    @State var translation = ""
    
    var body: some View {
        CustomNavigationBar(title: "Words", showLogo: inAppPurchaseViewModel.isSubscribed ? true : false, imageName: "Vector4324234", customNavBarState: .withBackButton) {
            ScrollView {
                VStack {
                    VStack {
                        KFImage(imageURL)
                            .placeholder {
                                Image("launchicon")
                            }
                            .resizable()
                            .frame(width: 231, height: 215)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text(wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "")
                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive24))
                        
                        Text(transcription)
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive19))
                            .padding(.vertical)
                        
                        Text(translation)
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive19))
                        
                        Button {
                            aIChatViewModel.speak(wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "")
                        } label: {
                            Image("gravity-ui_volume-fill")
                                .padding()
                                .background(
                                    LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                            Color(Color(hex: "#38A9CF") ?? .blue)],
                                                   startPoint: .leading,
                                                   endPoint: .trailing)
                                )
                                .clipShape(.circle)
                                .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 7)
                        }
                        .padding(.vertical)
                        
                        Text(example)
                            .font(.custom("Montserrat-Medium", size: AdaptiveFontSize.adaptive16))
                    }
                    .foregroundStyle(.white)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding()
                    
                    VStack {
                        Button {
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                            Task {
                                try await wordsViewModel.saveLearnedWord(wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "")
                            }
                            
                            Task {
                                try await wordsViewModel.deleteWord(wordsViewModel.savedWords[wordsViewModel.selectedIndex])
                                wordsViewModel.savedWords.remove(at: wordsViewModel.selectedIndex)
                                appRouter.goBack()
                            }
                        } label: {
                            Text("LEARNED")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                                .padding()
                                .frame(height: 62)
                                .frame(maxWidth: .infinity)
                                .background {
                                    LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                            Color(Color(hex: "#38A9CF") ?? .blue)],
                                                   startPoint: .leading,
                                                   endPoint: .trailing)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        .padding(.bottom)
                        
                        Button {
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                            wordsViewModel.selectedIndex += 1
                        } label: {
                            Text("NEXT WORD")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                                .padding()
                                .frame(height: 62)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(lineWidth: 3)
                                        .foregroundStyle(.white)
                                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 100)
            .onAppear {
                loadData()
            }
            .onChange(of: wordsViewModel.selectedIndex) {
                loadData()
            }
        }
    }
    
    
    private func loadData() {
        OpenAITranslator.translate(
            text: wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "",
            to: settingsViewModel.selectedLanguages
        ) { translatedText in
            DispatchQueue.main.async {
                translation = translatedText ?? "-"
            }
        }
        
        OpenAITranslator.makeIPA(for: wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "") { transcription in
            self.transcription = transcription ?? "[-]"
        }
        
        OpenAITranslator.makeSentence(with: wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "") { example in
            self.example = example ?? "-"
        }
        
        PexelsImageFetcher.shared.fetchImageURL(for: wordsViewModel.savedWords[wordsViewModel.selectedIndex].components(separatedBy: " - ").first ?? "") { url in
            DispatchQueue.main.async {
                self.imageURL = url
            }
        }
    }
}

#Preview {
    WordDetailView()
        .environmentObject(WordsViewModel())
        .environmentObject(AIChatViewModel())
        .environmentObject(SettingsViewModel())
        .environmentObject(AppRouter())
}
