//
//  WordsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.08.2025.
//

import SwiftUI

struct WordsView: View {
    
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var wordsViewModel: WordsViewModel
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurchaseViewModel

    @State private var showAlert = false
    
    
    var body: some View {
        CustomNavigationBar(title: "Words", showLogo: inAppPurchaseViewModel.isSubscribed ? true : false, imageName: "Vector4324234", customNavBarState: .withoutBackButton) {
            ZStack {
                VStack {
                    CustomSegmentControl()
                        .padding(.top, 27)
                    
                    switch wordsViewModel.segments {
                    case .flashcards:
                        ScrollView {
                            ForEach(Array(wordsViewModel.savedWords.enumerated()), id: \.element) { index, word in
                                WordCell(word: word.components(separatedBy: " - ").first ?? "")
                                    .onTapGesture {
                                        wordsViewModel.selectedIndex = index
                                        appRouter.goTo(.wordDetailView)
                                    }
                            }
                        }
                        .padding(.bottom, 75)
                        .padding(.horizontal)
                        
                    case .tests:
                        ScrollView {
                            VStack {
                                Image("Group 19641")
                                
                                Text("Check your knowledge")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive22))
                                    .padding(.vertical)
                                
                                Text("Select the number of questions for the test")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Medium", size: 16))
                                
                                HStack {
                                    Button {
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                        wordsViewModel.questionsCount = 5
                                    } label: {
                                        Text("5 questions")
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                                            .padding(35)
                                            .background {
                                                wordsViewModel.questionsCount == 5 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[Color(hex: "#262D3F") ?? .blue ], startPoint: .leading, endPoint: .trailing)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                            .shadow(
                                                color: Color.black.opacity(0.35),
                                                radius: 15,
                                                x: 0,
                                                y: 6
                                            )
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                        wordsViewModel.questionsCount = 10
                                    } label: {
                                        Text("10 questions")
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                                            .padding(35)
                                            .background {
                                                wordsViewModel.questionsCount == 10 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[Color(hex: "#262D3F") ?? .blue ], startPoint: .leading, endPoint: .trailing)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                            .shadow(
                                                color: Color.black.opacity(0.35),
                                                radius: 15,
                                                x: 0,
                                                y: 6
                                            )
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical)
                                
                                HStack {
                                    Button {
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                        wordsViewModel.questionsCount = 15
                                    } label: {
                                        Text("15 questions")
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                                            .padding(35)
                                            .background {
                                                wordsViewModel.questionsCount == 15 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[Color(hex: "#262D3F") ?? .blue ], startPoint: .leading, endPoint: .trailing)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                            .shadow(
                                                color: Color.black.opacity(0.35),
                                                radius: 15,
                                                x: 0,
                                                y: 6
                                            )
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                        wordsViewModel.questionsCount = 20
                                    } label: {
                                        Text("20 questions")
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive15))
                                            .padding(35)
                                            .background {
                                                wordsViewModel.questionsCount == 20 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[Color(hex: "#262D3F") ?? .blue ], startPoint: .leading, endPoint: .trailing)
                                                
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                            .shadow(
                                                color: Color.black.opacity(0.35),
                                                radius: 15,
                                                x: 0,
                                                y: 6
                                            )
                                    }
                                }
                                .padding(.horizontal)
                                
                                Button {
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                    if wordsViewModel.savedWords.count >= 5 {
                                        appRouter.goTo(.testsView)
                                    }else{
                                        showAlert = true
                                    }
                                } label: {
                                    HStack {
                                        Image("icon-park-solid_play")
                                        Text("START TEST")
                                    }
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
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
                                    .shadow(
                                        color: Color.black.opacity(0.35),
                                        radius: 15,
                                        x: 0,
                                        y: 6
                                    )
                                    .padding()
                                }
                                .alert("Not enough words", isPresented: $showAlert) {
                                    Button("OK", role: .cancel) { }
                                } message: {
                                    Text("Add 5 or more words")
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 75)
                    }
                    
                    Spacer()
                }
                .padding(.top, 73)
            }
            .ignoresSafeArea()
            .onAppear {
                wordsViewModel.fetchSavedWords()
            }
        }
    }
}


#Preview {
    WordsView()
        .environmentObject(WordsViewModel())
}
