//
//  CustomSegmentControl.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.12.2025.
//

import SwiftUI

enum Segments {
    case flashcards
    case tests
}

struct CustomSegmentControl: View {
    
    @EnvironmentObject var wordsViewModel: WordsViewModel
//    @State var segments: Segments = .flashcards
    
    var body: some View {
      
        HStack {
            
            Button {
                wordsViewModel.segments = .flashcards
            } label: {
                Text("Flashcards")
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background {wordsViewModel.segments == .flashcards ?
                        LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                Color(Color(hex: "#38A9CF") ?? .blue)],
                                       startPoint: .leading,
                                       endPoint: .trailing) : LinearGradient(colors: [Color.clear,
                                                                                      Color.clear],
                                                                                startPoint: .leading,
                                                                                endPoint: .trailing)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 26))                    .clipShape(RoundedRectangle(cornerRadius: 26))
            }
         
         
 
         
            
            Button {
                wordsViewModel.segments = .tests
            } label: {
                Text("Tests")
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background {wordsViewModel.segments == .tests ?
                        LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                Color(Color(hex: "#38A9CF") ?? .blue)],
                                       startPoint: .leading,
                                       endPoint: .trailing) : LinearGradient(colors: [Color.clear,
                                                                                      Color.clear],
                                                                                startPoint: .leading,
                                                                                endPoint: .trailing)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 26))
            }
           

        }
        .font(.custom("Montserrat-Bold", size: 14))
        .padding(7)
        .frame(maxWidth: .infinity)
        .background(
            BlurView(style: .systemUltraThinMaterialDark)
                .overlay(content: {
                    Color.black
                        .opacity(0.3)
                })
               // .opacity(0.8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .padding()
     
        
        
    }
    
}

#Preview {
    CustomSegmentControl()
        .environmentObject(WordsViewModel())
}
