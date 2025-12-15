//
//  FreeConversationView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 28.07.2025.
//

import SwiftUI
import AVFoundation
import Speech
import FirebaseAuth
import Combine

struct FreeChatView: View {
    
    @StateObject private var keyboard = KeyboardResponder()
    @EnvironmentObject var topicViewModel: TopicViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @EnvironmentObject var viewModel: AIChatViewModel
    @EnvironmentObject var simpleTimerViewModel: SimpleTimerViewModel
    @EnvironmentObject var dailyTapCounter: DailyTapCounter
    @Binding var savedWords: [String]
    
    
    var body: some View {
        CustomNavigationBar(title: topicViewModel.selectedTopic, showLogo: true, imageName: "Vector4324234", customNavBarState: .withBackButton) {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(viewModel.messagesHistory.enumerated()), id: \.offset) { index, message in
                            HStack {
                                
                                let isFirstAssistantMessage = index == 0 && message["role"] != "user"
                                let displayText = isFirstAssistantMessage
                                ? "Hello, I’m fine. How can I help you?"
                                : (message["content"] ?? "nil")
                                
                                if message["role"] == "user" {
                                    Spacer()
                                    Text(message["content"] ?? "nil")
                                        .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                        .foregroundStyle(.white)
                                        .padding()
                                        .background(Color(hex: "#313749"))
                                        .clipShape(
                                            RoundedCorner(radius: 25, corners: [.topLeft, .bottomRight, .bottomLeft])
                                        )
                                        .frame(maxWidth: 250, alignment: .trailing)
                                } else {
                                    VStack {
                                        if viewModel.showTranslateWord && viewModel.highlightedMessageIndex == index {
                                            HStack {
                                                Text("\(viewModel.translateWord) - \(viewModel.translatedWord)")
                                                
                                                if viewModel.translateOnlyWord {
                                                    Image("ic_round-save")
                                                        .padding(.horizontal, 7)
                                                    Text("Save")
                                                }
                                                Spacer()
                                            }
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                            .padding(.leading, 44)
                                            .onTapGesture {
                                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                                generator.impactOccurred()
                                                Task {
                                                    try await wordsViewModel.saveWord("\(viewModel.translateWord) - \(viewModel.translatedWord)" )
                                                    wordsViewModel.showSavedAlert = true
                                                    viewModel.showTranslateWord = false
                                                }
                                            }
                                        }
                                        
                                        HStack {
                                            HStack {
                                                VStack {
                                                    Image("gravity-ui_volume-fill")
                                                    Spacer()
                                                }
                                                .padding(.top, 5)
                                                
                                                WordTapView(
                                                    text: displayText,
                                                    savedWords: $savedWords,
                                                    messageIndex: index
                                                )
                                            }
                                            .padding()
                                            .background {
                                                LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                                            }
                                            .clipShape(
                                                RoundedCorner(radius: 25, corners: [.topLeft, .topRight, .bottomRight])
                                            )
                                            
                                        }
                                        .padding(.leading, 35)
                                        
                                        HStack {
                                            Image("launchicon")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                                .clipShape(.circle)
                                            HStack {
                                                Image("bi_translate")
                                                Text("Translate")
                                                    .foregroundStyle(.white)
                                                    .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                            }
                                            .padding(.top, 5)
                                            .padding(.bottom)
                                            
                                            Spacer()
                                        }
                                        .onTapGesture {
                                            OpenAITranslator.translate(
                                                text: displayText,
                                                to: settingsViewModel.selectedLanguages
                                            ) { translatedText in
                                                DispatchQueue.main.async {
                                                    withAnimation {
                                                        viewModel.highlightedMessageIndex = index // передати індекс
                                                        viewModel.translateWord = ""
                                                        viewModel.translateOnlyWord = false
                                                        viewModel.showTranslateWord = true
                                                        viewModel.translatedWord = translatedText ?? ""
                                                    }
                                                }
                                                print(translatedText ?? "Помилка перекладу")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .padding(.top, 120)
                .padding(.bottom, 75)
                
                VStack {
                    Spacer()
                    ZStack {
                        Group {
                            if viewModel.isRecording {
                                HStack {
                                    HStack {
                                        Circle()
                                            .fill(
                                                LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                                            )
                                            .frame(width: 10, height: 10)
                                        
                                        Text(simpleTimerViewModel.timeString)
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                        
                                    }
                                    
                                    Text("Recording...")
                                        .foregroundStyle(.gray)
                                    
                                    Spacer()
                                }
                                .padding()
                                .padding(.vertical, 5)
                                .background(Color(hex: "#232A3A"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .padding()
                                
                            } else {
                                TextField("Write your message", text: $viewModel.transcribedText)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .padding(.vertical, 5)
                                    .background(Color(hex: "#232A3A"))
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .padding()
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                if !viewModel.isRecording {
                                    dailyTapCounter.registerTap()
                                }
                                
                                if viewModel.isRecording {
                                    simpleTimerViewModel.stop()
                                }else{
                                    simpleTimerViewModel.reset()
                                    simpleTimerViewModel.start()
                                }
                                viewModel.toggleRecording()
                            }) {
                                Image(viewModel.isRecording ? "icon-park-solid_voicee" : "icon-park-solid_voice")
                            }
                            
                            Button(action: {
                                viewModel.sendToOpenAI()
                            }) {
                                Image("ion_send")
                            }
                            .padding()
                        }
                        .padding(.trailing)
                    }
                    .padding(.bottom, keyboard.currentHeight) // <- додаємо відступ під клавіатуру
                    .animation(.easeOut(duration: 0.25), value: keyboard.currentHeight)
                }
                .padding(.bottom)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .alert("Words saving", isPresented: $wordsViewModel.showSavedAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Word \(viewModel.translateWord) saved")
            }
        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


#Preview {
    @Previewable @StateObject var settingsViewModel = SettingsViewModel()
    @Previewable @State var savedWords: [String] = []
    FreeChatView(savedWords: $savedWords)
        .environmentObject(AIChatViewModel())
        .environmentObject(SimpleTimerViewModel())
        .environmentObject(WordsViewModel())
        .environmentObject(SettingsViewModel())
        .environmentObject(TopicViewModel(settings: settingsViewModel))
}



class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = []

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(willShow, willHide)
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellables)
    }
}
