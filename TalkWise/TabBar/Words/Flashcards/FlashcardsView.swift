//
//  WordCardsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

enum FlashcardsViewState {
    case list
    case card
}


struct FlashcardsView: View {
    
    @State var savedWords: [String]
    @State var imageURL: URL?
    @State var flashcardsViewState: FlashcardsViewState = .list
    
    var body: some View {
        
        ScrollView {
            
            switch flashcardsViewState {
                
            case .list:
                ForEach(savedWords, id: \.self) { word in
                    VStack {
                        FlashcardsCell(word: word)
                            .onTapGesture {
                                PexelsImageFetcher.shared.fetchImageURL(for: word) { url in
                                    DispatchQueue.main.async {
                                        self.imageURL = url
                                        self.flashcardsViewState = .card
                                    }
                                }
                                
                            }
                    }
                }
                
            case .card:
                if let image = imageURL {
                    FlashcardsImage(imageURL: image)
                        .onTapGesture {
                            self.flashcardsViewState = .list
                        }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var savedWords: [String] = []
    FlashcardsView(savedWords: savedWords)
}

