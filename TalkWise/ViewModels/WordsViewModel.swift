//
//  WordsViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 03.12.2025.
//

import Foundation

class WordsViewModel: ObservableObject {
    @Published var segments: Segments = .tests
    @Published var questionsCount = 5
    @Published var progress: CGFloat = 0.0
    
}
