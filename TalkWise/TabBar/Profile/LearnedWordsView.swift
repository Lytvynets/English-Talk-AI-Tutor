//
//  Learned words.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 07.12.2025.
//

import SwiftUI

struct LearnedWordsView: View {
    var body: some View {
        CustomNavigationBar(title: "Learned words", imageName: "Vector 28654363", customNavBarState: .withBackButton) {
            
            ScrollView {
                LearnedWordsCell()
                LearnedWordsCell()
                LearnedWordsCell()
                LearnedWordsCell()
                LearnedWordsCell()
                LearnedWordsCell()
                LearnedWordsCell()
                LearnedWordsCell()
                
            }
            .padding(.horizontal)
            .padding(.top, 120)
        }
    }
}

#Preview {
    LearnedWordsView()
}
