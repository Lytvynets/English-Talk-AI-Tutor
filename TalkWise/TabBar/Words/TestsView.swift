//
//  TestsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 07.12.2025.
//

import SwiftUI

struct TestsView: View {
    
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var wordsViewModel: WordsViewModel
    
    
    var body: some View {
        
        CustomNavigationBar(title: "Tests", imageName: "Vector4324234", customNavBarState: .withBackButton) {
            
            VStack {
                
                ScrollView{
                    
                    VStack {
                        HStack {
                            Text("Progress")
                                .font(.custom("Montserrat-Regular", size: 14))
                            Spacer()
                            Text("4/5")
                                .font(.custom("Montserrat-Regular", size: 14))
                        }
                        .padding(.horizontal, 7)
                        .padding(.bottom)
                        .padding(.top, 5)
                        .foregroundStyle(.white)
                        
                        CustomProgressBar(progress: wordsViewModel.progress)
                    }
                    .padding()
                    .background(
                        BlurView(style: .systemUltraThinMaterialDark)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    )
                    .padding(.horizontal)
                    
                    Text("What is this?")
                        .foregroundStyle(.white)
                        .font(.custom("Montserrat-Bold", size: 18))
                        .padding(.vertical)
                    
                    Image("launchicon")
                        .resizable()
                        .frame(width: 231, height: 215)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack {
                        Button {
                            wordsViewModel.questionsCount = 5
                        } label: {
                            Text("Tree")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: 16))
                                .frame(width: 165, height: 92)
                                .background {
                                    wordsViewModel.questionsCount == 5 ? LinearGradient(colors: [Color(Color(hex: "#24AF5C") ?? .blue), Color(Color(hex: "#14A9A4") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                        }
                        
                        Spacer()
                        
                        Button {
                            wordsViewModel.questionsCount = 10
                        } label: {
                            Text("Apple")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: 16))
                                .frame(width: 165, height: 92)
                                .background {
                                    wordsViewModel.questionsCount == 10 ? LinearGradient(colors: [Color(Color(hex: "#A63B4D") ?? .blue), Color(Color(hex: "#822933") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    
                    
                    HStack {
                        Button {
                            wordsViewModel.questionsCount = 15
                        } label: {
                            Text("Dog")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: 16))
                                .frame(width: 165, height: 92)
                                .background {
                                    wordsViewModel.questionsCount == 15 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                        }
                        
                        Spacer()
                        
                        Button {
                            wordsViewModel.questionsCount = 20
                        } label: {
                            Text("House")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: 16))
                            
                                .frame(width: 165, height: 92)
                                .background {
                                    wordsViewModel.questionsCount == 20 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                        }
                    }
                    .padding(.horizontal)
                    
                    Button {
                        withAnimation {
                            wordsViewModel.progress += 0.2
                        }
                        
                    } label: {
                        Text("CONTINUE")
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Bold", size: 17))
                            .padding()
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .background {
                                LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                                        Color(Color(hex: "#38A9CF") ?? .blue)],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .padding()
                        
                    }
                    
                    
                }
                .padding(.top, 110)
            }
            
            
            
        }
    }
    
}

#Preview {
    TestsView()
        .environmentObject(AppRouter())
        .environmentObject(WordsViewModel())
}


struct CustomProgressBar: View {
    var progress: CGFloat // 0...1
    
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
