//
//  LearnedWordsCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 08.12.2025.
//

import SwiftUI

struct LearnedWordsCell: View {
    
    @State var showDeleteButton = false
    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        
        HStack {
            HStack(spacing: 20) {
                Image("launchicon")
                    .resizable()
                    .frame(width: 57, height: 53)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Button {
                    print("")
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
                }
                
                Text("Apple")
                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                    .foregroundStyle(.white)
                
                Spacer()
                
            }
            .padding()
            .background(
                BlurView(style: .systemUltraThinMaterialDark)
                    .overlay(content: {
                        Color.black
                            .opacity(0.15)
                    })
//                    .opacity(0.7)
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
            
            
            if showDeleteButton {
                
                HStack {
                    Image("gdfsddfdsfdsf")
                }
                .padding(20)
                .padding()
                .background(
                    LinearGradient(colors: [Color(Color(hex: "#A63B4D") ?? .blue),
                                            Color(Color(hex: "#822933") ?? .blue)],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
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
    LearnedWordsCell()
}
