//
//  DiamondPageControl.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 13.08.2025.
//

import SwiftUI

struct DiamondPageControl: View {
    
    let numberOfPages: Int
    @Binding var currentPage: Int
    
    private let diamondSize: CGFloat = 14
    private let spacing: CGFloat = 16
    private let activeColor: Color = .yellow
    private let inactiveColor: Color = Color.white.opacity(0.4)
    private let activeScale: CGFloat = 1.4
    private let animation: Animation = .easeOut(duration: 0.25)
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<max(0, numberOfPages), id: \.self) { index in
                Button {
                    withAnimation(animation) {
                        currentPage = index
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 3, )
                        .fill(index == currentPage ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .bottom, endPoint: .topTrailing) : LinearGradient(colors: [Color(Color(hex: "#4B4F58") ?? .blue), Color(Color(hex: "#4B4F58") ?? .blue)], startPoint: .leading, endPoint: .trailing))
                        .frame(width: diamondSize, height: diamondSize)
                        .rotationEffect(.degrees(45))
                        .scaleEffect(index == currentPage ? activeScale : 1)
                }
                .buttonStyle(.plain)
                .animation(animation, value: currentPage)
            }
        }
        .padding(.vertical, 6)
    }
}


#Preview {
    @Previewable @State var currentIndex = 0
    DiamondPageControl(numberOfPages: 0, currentPage: $currentIndex)
}
