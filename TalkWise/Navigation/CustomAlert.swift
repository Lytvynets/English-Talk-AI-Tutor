//
//  CustomAlert.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 13.12.2025.
//

import SwiftUI

struct CustomAlert: View {
    
    @State var textAlert: String
    let yesButton: (() -> Void)
    let noButton: (() -> Void)
    
    var body: some View {
        VStack(alignment: .center) {
            Text(textAlert)
                .foregroundStyle(.white)
                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive18))
                .multilineTextAlignment(.center)
                .padding()
            
            Image("Group 19648")
            
            Button {
                yesButton()
            } label: {
                Text("YES")
                    .foregroundStyle(.white)
                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background {
                        LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                Color(Color(hex: "#38A9CF") ?? .blue)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .padding(.top, 25)
            .padding(.bottom, 5)
            
            Button {
                noButton()
            } label: {
                Text("NO")
                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.white)
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 50))
        }
        .padding(.bottom, 25)
        .padding()
        .background(Color(hex: "#232A3A"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CustomAlert(textAlert: "Are you sure you want to stop the test?") {
        print("yes")
    } noButton: {
        print("no")
    }
}
