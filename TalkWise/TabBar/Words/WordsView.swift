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
    
    var body: some View {
        
        ZStack {
            Color(hex: "#212737")
                .ignoresSafeArea()
            
            VStack {
                Image("Vector4324234")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
            }
            
            VStack {
                
                HStack {
                    Spacer()
                    
                    Text("Words")
                        .font(.custom("Montserrat-Bold", size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Image("pixel_pro-solid")
                    
                }
                
                CustomSegmentControl()
                
                switch wordsViewModel.segments {
                case .flashcards:
                    ScrollView {
                        //ForEach(wordsViewModel.savedWords, id: \.self) { word in
                        ForEach(Array(wordsViewModel.savedWords.enumerated()), id: \.element) { index, word in
                            WordCell(word: word.components(separatedBy: " - ").first ?? "")
                                .onTapGesture {
                                   // wordsViewModel.selectedWord = word
                                    wordsViewModel.selectedIndex = index
                                    appRouter.goTo(.wordDetailView)
                                }
                        }
                        
//                        WordCell()
//                            .onTapGesture {
//                                appRouter.goTo(.wordDetailView)
//                            }
//                        WordCell()
//                        WordCell()
//                        WordCell()
//                        WordCell()
//                        WordCell()
//                        WordCell()
                    }
                    .padding(.horizontal)
                case .tests:
                    VStack {
                        Image("Group 19641")
                        
                        Text("Check your knowledge")
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Bold", size: 22))
                            .padding(.vertical)
                        
                        Text("Select the number of questions for the test")
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Medium", size: 16))
                        
                        
                        HStack {
                            Button {
                                wordsViewModel.questionsCount = 5
                            } label: {
                                Text("5 questions")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: 16))
                                    .padding(35)
                                    .background {
                                        wordsViewModel.questionsCount == 5 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                            }
                            
                            Spacer()
                            
                            Button {
                                wordsViewModel.questionsCount = 10
                            } label: {
                                Text("10 questions")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: 16))
                                    .padding(35)
                                    .background {
                                        wordsViewModel.questionsCount == 10 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
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
                                Text("15 questions")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: 16))
                                    .padding(35)
                                    .background {
                                        wordsViewModel.questionsCount == 15 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                            }
                            
                            Spacer()
                            
                            Button {
                                wordsViewModel.questionsCount = 20
                            } label: {
                                Text("20 questions")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: 16))
                                    .padding(35)
                                    .background {
                                        wordsViewModel.questionsCount == 20 ? LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing): LinearGradient(colors:[.clear], startPoint: .leading, endPoint: .trailing)
                                        
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 40))

                            }
                            
                            
                        }
                        .padding(.horizontal)
                        
                        Button {
                            appRouter.goTo(.testsView)
                        } label: {
                            Text("START TEST")
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

#Preview {
    WordsView()
        .environmentObject(WordsViewModel())
}
