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
    @EnvironmentObject var testViewModel: TestViewModel
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurchaseViewModel

    @State private var selectedOption: String?
    @State private var showResult = false
    @State private var currentIndex = 0
    
    
    var body: some View {
        CustomNavigationBar(title: "Tests", showLogo: inAppPurchaseViewModel.isSubscribed ? true : false, imageName: "Vector4324234", customNavBarState: .withBackButton, onBack: {
            testViewModel.showAlert = true
        } ) {
            ZStack {
                VStack {
                    ScrollView{
                        VStack {
                            HStack {
                                Text("Progress")
                                    .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive14))
                                Spacer()
                                Text("\(currentIndex + 1)/\(wordsViewModel.questionsCount)")
                                    .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive14))
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
                        
                        
                        if !testViewModel.testCompleted {
                            
                            Text("What is this?")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive18))
                                .padding(.vertical)
                            
                            if testViewModel.isLoading {
                                ProgressView("Loading...")
                            } else if !testViewModel.questions.isEmpty {
                                let question = testViewModel.questions[currentIndex]
                                
                                AsyncImage(url: question.imageURL) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 231, height: 215)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                let columns = [
                                    GridItem(.flexible(), spacing: 20),
                                    GridItem(.flexible(), spacing: 20)
                                ]
                                
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(question.options, id: \.self) { option in
                                        Button {
                                            if !showResult {
                                                selectedOption = option
                                                showResult = true
                                            }
                                            if option == question.correctWord {
                                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                                generator.impactOccurred()
                                                testViewModel.correctAnswers += 1
                                            }else{
                                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                                generator.prepare()
                                                generator.impactOccurred()
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                                                    generator.impactOccurred()
                                                }
                                                testViewModel.incorrectAnswers += 1
                                            }
                                        } label: {
                                            Text(option.components(separatedBy: " - ").first ?? "")
                                                .foregroundStyle(.white)
                                                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive16))
                                                .frame(width: 165, height: 92)
                                                .background(
                                                    showResult
                                                    ? (
                                                        option == question.correctWord
                                                        ? LinearGradient(
                                                            colors: [
                                                                Color(Color(hex: "#24AF5C") ?? .green),
                                                                Color(Color(hex: "#14A9A4") ?? .green)
                                                            ],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        )
                                                        :
                                                            (option == selectedOption
                                                             ? LinearGradient(
                                                                colors: [
                                                                    Color(Color(hex: "#A63B4D") ?? .red),
                                                                    Color(Color(hex: "#822933") ?? .red)
                                                                ],
                                                                startPoint: .leading,
                                                                endPoint: .trailing
                                                             )
                                                             :
                                                                LinearGradient(
                                                                    colors: [
                                                                        Color(Color(hex: "#262D3F") ?? .blue)
                                                                    ],
                                                                    startPoint: .leading,
                                                                    endPoint: .trailing
                                                                )
                                                            )
                                                    )
                                                    :
                                                        LinearGradient(
                                                            colors: [
                                                                Color(Color(hex: "#262D3F") ?? .blue)
                                                            ],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        )
                                                )
                                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                                .shadow(
                                                    color: Color.black.opacity(0.35),
                                                    radius: 15,
                                                    x: 0,
                                                    y: 6
                                                )
                                        }
                                    }
                                }
                                
                                Button {
                                    showResult = false
                                    selectedOption = nil
                                    if currentIndex < testViewModel.questions.count - 1 {
                                        currentIndex += 1
                                        withAnimation {
                                            wordsViewModel.progress = CGFloat(currentIndex) / CGFloat(testViewModel.questions.count - 1)
                                        }
                                    } else {
                                        testViewModel.testCompleted = true
                                    }
                                } label: {
                                    Text("CONTINUE")
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
                                        .padding()
                                }
                            }
                        }else{
                            Text("Test completed")
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive18))
                                .padding(.vertical)
                            
                            Image("Group 19644")
                            
                            HStack {
                                Text("Correct answers")
                                
                                Spacer()
                                
                                Text("\(testViewModel.correctAnswers)")
                                    .padding()
                                    .padding(.horizontal)
                                    .background(
                                        LinearGradient(
                                            colors: [
                                                Color(Color(hex: "#24AF5C") ?? .green),
                                                Color(Color(hex: "#14A9A4") ?? .green)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .clipShape(.capsule)
                            }
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive16))
                            .padding(.horizontal)
                            .padding(.vertical, 7)
                            
                            HStack {
                                Text("Incorrect answers")
                                
                                Spacer()
                                
                                Text("\(testViewModel.incorrectAnswers)")
                                    .padding()
                                    .padding(.horizontal)
                                    .background(
                                        LinearGradient(
                                            colors: [
                                                Color(Color(hex: "#A63B4D") ?? .red),
                                                Color(Color(hex: "#822933") ?? .red)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .clipShape(.capsule)
                            }
                            .foregroundStyle(.white)
                            .font(.custom("Montserrat-Regular", size: AdaptiveFontSize.adaptive16))
                            .padding(.horizontal)
                            
                            Button {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                withAnimation {
                                    testViewModel.testCompleted = false
                                    wordsViewModel.progress = 0.0
                                    currentIndex = 0
                                    showResult = false
                                    selectedOption = nil
                                    testViewModel.correctAnswers = 0
                                    testViewModel.incorrectAnswers = 0
                                }
                                
                                testViewModel.generateTest(words: wordsViewModel.savedWords, count: wordsViewModel.questionsCount)
                            } label: {
                                Text("START TEST AGAIN")
                                    .foregroundStyle(.white)
                                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                                    .padding(20)
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
                            .padding(.top)
                            
                            Button {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                appRouter.goBack()
                            } label: {
                                Text("BACK TO MENU")
                                    .font(.custom("Montserrat-Bold", size: AdaptiveFontSize.adaptive17))
                                    .foregroundStyle(.white)
                                    .padding(20)
                                    .frame(width: UIScreen.main.bounds.width / 1.1)
                                    .background {
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(lineWidth: 2)
                                            .foregroundStyle(.white)
                                    }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                        }
                    }
                    .padding(.top, 110)
                }
                .onAppear {
                    currentIndex = 0
                    testViewModel.correctAnswers = 0
                    testViewModel.incorrectAnswers = 0
                    wordsViewModel.progress = 0.0
                    showResult = false
                    selectedOption = nil
                    testViewModel.generateTest(words: wordsViewModel.savedWords, count: wordsViewModel.questionsCount)
                    DispatchQueue.main.async {
                        print("questions count \(testViewModel.questions.count)")
                    }
                }
                
                if testViewModel.showAlert {
                    BlurView(style: .systemUltraThinMaterialDark)
                        .ignoresSafeArea()
                    
                    CustomAlert(textAlert: "Are you sure you want to stop the test?") {
                        appRouter.goBack()
                    } noButton: {
                        testViewModel.showAlert = false
                    }
                }
            }
        }
    }
}

#Preview {
    TestsView()
        .environmentObject(AppRouter())
        .environmentObject(WordsViewModel())
        .environmentObject(TestViewModel())
}
