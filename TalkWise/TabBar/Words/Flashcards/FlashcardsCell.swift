//
//  FlashcardsCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.08.2025.
//

import SwiftUI

struct FlashcardsCell: View {
    
    @State var word: String
    
    var body: some View {
      
        HStack {
            Text(word)
                .foregroundStyle(.white)
                .font(.custom("", size: 20))
            
            Spacer()
        }
        .padding()
        .background(.brown)
        
    }
}

#Preview {
    FlashcardsCell(word: "Apple")
}
