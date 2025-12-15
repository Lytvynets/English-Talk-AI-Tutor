//
//  WordCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.12.2025.
//

import SwiftUI
import Kingfisher

struct WordCell: View {
    
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @State var word: String
    @State var imageURL: URL?
    
    
    var body: some View {
        HStack {
            KFImage(imageURL)
                .placeholder {
                    Image("launchicon")
                }
                .resizable()
                .frame(width: 57, height: 53)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(word)
                .foregroundStyle(.white)
                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                .padding(.leading)
            
            Spacer()
            
            Image("Vector 13452342")
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            BlurView(style: .systemUltraThinMaterialDark)
                .overlay(content: {
                    Color.black
                        .opacity(0.15)
                })
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear {
            PexelsImageFetcher.shared.fetchImageURL(for: word) { url in
                DispatchQueue.main.async {
                    self.imageURL = url
                }
            }
        }
    }
}

#Preview {
    WordCell(word: "Test")
}
