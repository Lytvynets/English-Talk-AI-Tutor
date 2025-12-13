//
//  CustomProgressBar.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 12.12.2025.
//

import SwiftUI

struct CustomProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing))
                    .frame(width: geometry.size.width * progress)
            }
        }
        .frame(height: 8)
        .padding(.horizontal, 7)
        .padding(.bottom, 7)
    }
}

#Preview {
    CustomProgressBar(progress: 0.5)
}
