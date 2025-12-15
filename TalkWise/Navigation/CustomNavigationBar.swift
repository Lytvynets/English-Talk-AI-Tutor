//
//  CustomNavigationBar.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 07.12.2025.
//

import SwiftUI

enum CustomNavBarState {
    case withBackButton
    case withoutBackButton
    
}

struct CustomNavigationBar<Content: View>: View {
    
    let title: String
    let showLogo: Bool
    let imageName: String
    let content: Content
    let onBack: (() -> Void)?
    let customNavBarState: CustomNavBarState
    @Environment(\.dismiss) private var dismiss
    
    init(title: String, showLogo: Bool, imageName: String, customNavBarState: CustomNavBarState, onBack: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.imageName = imageName
        self.content = content()
        self.customNavBarState = customNavBarState
        self.onBack = onBack
        self.showLogo = showLogo
    }
    
    var body: some View {
        ZStack {
            switch customNavBarState {
            case .withBackButton:
                ZStack {
                    
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            
                            Button {
                                if let onBack = onBack {
                                    onBack()
                                } else {
                                    dismiss()
                                }
                            } label: {
                                Image("Vector 13452342")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .rotationEffect(Angle(radians: 15.7))
                            }
                            Spacer()
                            Text(title)
                                .font(.system(size: AdaptiveFontSize.adaptive24, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.trailing)
                            Spacer()
                        }
                        .padding(.bottom, 7)
                        .padding()
                        .padding(.top, 55)
                        .overlay {
                            if showLogo {
                                HStack {
                                    Spacer()
                                    Image("pixel_pro-solid")
                                }
                                .padding()
                                .padding(.top, 45)
                                
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            case .withoutBackButton:
                
                ZStack {
                    
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            
                  
                            Spacer()
                            Text(title)
                                .font(.system(size: AdaptiveFontSize.adaptive24, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                       
                            Spacer()
                        }
                        .padding(.bottom, 7)
                        .padding()
                        .padding(.top, 55)
                        .overlay {
                            if showLogo {
                                HStack {
                                    Spacer()
                                    Image("pixel_pro-solid")
                                }
                                .padding()
                                .padding(.top, 45)
                                
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
//                ZStack {
//                    
//                    VStack {
//                        Image(imageName)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(maxWidth: .infinity)
//                        
//                        Spacer()
//                        
//                    }
//                    
//                    VStack {
//                        
//                        HStack {
//                            
//                            
//                            Spacer()
//                            
//                            Text(title)
//                                .font(.system(size: AdaptiveFontSize.adaptive24, weight: .semibold, design: .rounded))
//                                .font(.headline)
//                            
//                            Spacer()
//                        }
//                        .padding(.bottom, 7)
//                        .padding()
//                        .padding(.top, 55)
//                        .overlay {
//                            if showLogo {
//                                HStack {
//                                    Spacer()
//                                    Image("pixel_pro-solid")
//                                }
//                                .padding()
//                                .padding(.top, 45)
//                                
//                            }
//                            
//                            Spacer()
//                        }
//                    }
//                }
//                
//                
//                content
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color(hex: "#212737"))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    CustomNavigationBar(title: "Test", showLogo: true, imageName: "Vector4324234", customNavBarState: .withBackButton) {
        Text("Test")
    }
}
