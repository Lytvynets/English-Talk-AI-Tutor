//
//  Learned words.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 07.12.2025.
//

import SwiftUI

struct LearnedWordsView: View {
    
    @EnvironmentObject var wordsViewModel: WordsViewModel
    
    
    var body: some View {
        CustomNavigationBar(title: "Learned words", imageName: "Vector 28654363", customNavBarState: .withBackButton) {
            
            ZStack {
                ScrollView {
                    
                    ForEach(Array(wordsViewModel.learnedWords.enumerated()), id: \.element) { index, word in
                        LearnedWordsCell(word: word.components(separatedBy: " - ").first ?? "")
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 120)
                
                
                
                if wordsViewModel.showAlert {
                    
                    BlurView(style: .systemUltraThinMaterialDark)
                        .ignoresSafeArea()
                    
                    
                    CustomAlert(textAlert: "Are you sure you want to delete this word?") {
                        Task {
                            try await wordsViewModel.deleteLearnedWord(wordsViewModel.wordToDelete)
                            wordsViewModel.fetchLearnedWords()
                            wordsViewModel.wordToDelete = ""
                            wordsViewModel.showAlert = false
                        }
                        
                    } noButton: {
                        
                        wordsViewModel.showAlert = false
                    }
                    
                }
                
                
            }
            .onAppear {
                wordsViewModel.fetchLearnedWords()
            }
        }
    }
}

#Preview {
    LearnedWordsView()
}
