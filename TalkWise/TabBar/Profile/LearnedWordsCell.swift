//
//  LearnedWordsCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 08.12.2025.
//

import SwiftUI

struct LearnedWordsCell: View {
    
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @EnvironmentObject var aIChatViewModel: AIChatViewModel
    @State var showDeleteButton = false
    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State var word: String
    
    var body: some View {
        
        HStack {
            HStack(spacing: 20) {
                Image("launchicon")
                    .resizable()
                    .frame(width: 57, height: 53)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Button {
                    aIChatViewModel.speak(word.components(separatedBy: " - ").first ?? "")
                } label: {
                    Image("gdfsddfdsfdsf")
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
                
                Text(word)
                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                    .foregroundStyle(.white)
                
                Spacer()
                
            }
            .padding(10)
            .background(
                BlurView(style: .systemUltraThinMaterialDark)
                    .overlay(content: {
                        Color.black
                            .opacity(0.15)
                    })
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        if value.translation.width < 0 {
                            state = value.translation.width
                        }
                    }
                    .onEnded(onDragEnded)
            )
            .onTapGesture {
                withAnimation {
                    showDeleteButton = false
                }
            }
            
            
            if showDeleteButton {
                HStack {
                    Image("hgoijergoiwejfiojewfe")
                }
                .padding(27)
                .background(
                    LinearGradient(colors: [Color(Color(hex: "#A63B4D") ?? .blue),
                                            Color(Color(hex: "#822933") ?? .blue)],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .onTapGesture {
                    wordsViewModel.showAlert = true
                    wordsViewModel.wordToDelete = word
                }
            }
        }
        .animation(.spring(), value: offset)
        
    }
    
    
    private func onDragEnded(_ value: DragGesture.Value) {
        let threshold: CGFloat = -80
        if value.translation.width < threshold {
            offset = -80
            showDeleteButton = true
        } else {
            offset = 0
        }
    }
    
    
}



#Preview {
    LearnedWordsCell(word: "Test")
}
