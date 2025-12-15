//
//  TypewriterText.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.12.2025.
//

import SwiftUI

struct TypewriterText: View {
    let text: String
    @State private var visibleText = ""
    private let haptic = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        Text(visibleText)
            .onAppear {
                visibleText = ""
                haptic.prepare()
                for (index, char) in text.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                        visibleText.append(char)
                        haptic.impactOccurred(intensity: 0.3)
                    }
                }
            }
    }
}


#Preview {
    TypewriterText(text: "Test")
}
