//
//  FreeConversationView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 28.07.2025.
//

import SwiftUI
import AVFoundation
import Speech

struct FreeChatView: View {
    
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @EnvironmentObject var viewModel: AIChatViewModel
    @Binding var savedWords: [String]
    
    var body: some View {
        CustomNavigationBar(title: "Free Conversation", imageName: "Vector4324234", customNavBarState: .withBackButton) {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(viewModel.messagesHistory.enumerated()), id: \.offset) { index, message in
                            HStack {
                                
                                //треба перевірити
                                let isFirstAssistantMessage = index == 0 && message["role"] != "user"
                                let displayText = isFirstAssistantMessage
                                    ? "Hello, I’m fine. How can I help you?"
                                    : (message["content"] ?? "nil")
                                //треба перевірити
                                
                                
                                if message["role"] == "user" { // тут теба додати id user
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
                                        if  viewModel.showTranslateWord {
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
                                                Task {
                                                  try await wordsViewModel.saveWord("\(viewModel.translateWord) - \(viewModel.translatedWord)" )
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
                                                
                                                //треба перевірити
                                                WordTapView(
                                                    text: displayText,
                                                    savedWords: $savedWords
                                                )
                                                //треба перевірити
                                                
//                                                WordTapView(text: message["content"] ?? "nil",
//                                                            savedWords: $savedWords)
                                                
                                                
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
                                            //треба перевірити
//                                            OpenAITranslator.translate(text: message["content"] ?? "nil", to: "ukrainian") { translatedText in
                                            //треба перевірити
                                            OpenAITranslator.translate(
                                                text: displayText,
                                                to: "ukrainian"
                                            ) { translatedText in
                                                DispatchQueue.main.async {
                                                    viewModel.translateWord = ""
                                                    viewModel.translateOnlyWord = false
                                                    viewModel.showTranslateWord = true
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
                }
                .padding()
                .padding(.top, 120)
                .padding(.bottom, 75)
                
                VStack {
                    Spacer()
                    ZStack {
                        TextField("Write your message", text: $viewModel.transcribedText)
                            .padding()
                            .padding(.vertical, 5)
                            .background(Color(hex: "#232A3A"))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding()
                        
                        HStack {
                            Spacer()
                            Button(action: {
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
                }
                .padding(.bottom)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


#Preview {
    @Previewable @State var savedWords: [String] = []
    FreeChatView(savedWords: $savedWords)
        .environmentObject(AIChatViewModel())
}
