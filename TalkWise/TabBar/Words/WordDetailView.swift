//
//  WordDetailView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 07.12.2025.
//

import SwiftUI

struct WordDetailView: View {
    
    
    var body: some View {
        
        CustomNavigationBar(title: "Words", imageName: "Vector4324234", customNavBarState: .withBackButton) {
            
            ScrollView {
                VStack {
                    VStack {
                        Image("launchicon")
                            .resizable()
                            .frame(width: 231, height: 215)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                        Text("Apple")
                            .font(.custom("Montserrat-Bold", size: 24))
                        
                        Text("[ˈæpəl]")
                            .font(.custom("Montserrat-Medium", size: 19))
                        
                        Button {
                            print("1")
                        } label: {
                            Image("dfigldfjglkdsfds")
                        }
                        
                        Text("My apple is red")
                            .font(.custom("Montserrat-Medium", size: 16))
                    }
                    .foregroundStyle(.white)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                        
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding()
                    
                    
                    
                    VStack {
                        Button {
                            print("")
                        } label: {
                            Text("LEARNED")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: 17))
                                .padding()
                                .frame(height: 62)
                                .frame(maxWidth: .infinity)
                                .background {
                                    LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                            Color(Color(hex: "#38A9CF") ?? .blue)],
                                                   startPoint: .leading,
                                                   endPoint: .trailing)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                            
                        }
                        .padding(.bottom)
                        
                        Button {
                            print("")
                        } label: {
                            Text("NEXT WORD")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: 17))
                                .padding()
                                .frame(height: 62)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(lineWidth: 3)
                                        .foregroundStyle(.white)
                                
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    
                }
              
            }
            .padding(.top, 100)
            
            
        }
        
        
    }
}

#Preview {
    WordDetailView()
}
