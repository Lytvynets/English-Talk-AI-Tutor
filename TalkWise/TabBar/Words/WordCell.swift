//
//  WordCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.12.2025.
//

import SwiftUI

struct WordCell: View {
    
    var body: some View {
        
        HStack {
            Image("launchicon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 57, height: 53)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("Apple")
                .foregroundStyle(.white)
                .font(.custom("Montserrat-Bold", size: 16))
            
            Spacer()
            
            Image("Vector 13452342")
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            BlurView(style: .systemUltraThinMaterialDark)
           //     .opacity(0.8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
      
    }
}

#Preview {
    WordCell()
}
