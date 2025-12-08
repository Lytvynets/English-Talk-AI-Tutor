//
//  FlashcardsImage.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.08.2025.
//

import SwiftUI

struct FlashcardsImage: View {
    
    @State var imageURL: URL
    
    var body: some View {
        
        VStack {
            AsyncImage(url: imageURL)
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fit)
            
        }
    }
}

#Preview {
    //  FlashcardsImage(imageURL: URL(string: "") ?? <#default value#>)
}
