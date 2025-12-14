//
//  TestViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 12.12.2025.
//

import Foundation

class TestViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var isLoading = false
    @Published var testCompleted = false
    @Published var correctAnswers = 0
    @Published var incorrectAnswers = 0
    @Published var showAlert = false

    
    
    func generateTest(words: [String], count: Int) {
        isLoading = true
        questions.removeAll()
        
        // 1. Беремо рандомні слова
        let selectedWords = Array(words.shuffled().prefix(count))
        
        var tempQuestions: [Question] = []
        let group = DispatchGroup()
        
        for word in selectedWords {
            group.enter()
            
            PexelsImageFetcher.shared.fetchImageURL(for: word) { url in
                if let url = url {
                    
                    // 2. Створюємо 4 варіанти
                    let incorrect = words
                        .filter { $0 != word }
                        .shuffled()
                        .prefix(3)
                    
                    let options = ([word] + incorrect).shuffled()
                    
                    let q = Question(
                        imageURL: url,
                        correctWord: word,
                        options: options
                    )
                    
                    DispatchQueue.main.async {
                        tempQuestions.append(q)
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.questions = tempQuestions.shuffled()
            self.isLoading = false
        }
    }
}
