//
//  TopicCell.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 14.08.2025.
//

import SwiftUI

struct TopicCell: View {
    
    @State var title: String
    @State var iconName: String
    
    
    var body: some View {
        
        HStack {
            Image(iconName)
                .resizable()
                .frame(width: 32, height: 32)
                .aspectRatio(contentMode: .fit)
                .padding()
                .padding(.leading, 7)
            
            Text(title)
                .font(.custom("Montserrat-Bold", size: 16))
                .foregroundStyle(.white)
                .padding(.vertical, 25)
            
            
            Spacer()
            
            Image("Vector 13452342")
                .padding()
        }
        .background(
            BlurView(style: .systemUltraThinMaterialDark)
        )
       // .background(Color(hex: "#262D3F"))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
        
       
    }
    
    
}

#Preview {
    TopicCell(title: "Test", iconName: "Group3243242")
}
