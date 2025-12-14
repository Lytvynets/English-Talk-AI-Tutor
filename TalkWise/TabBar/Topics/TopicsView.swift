//
//  TopicsView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

struct TopicsView: View {
    
    @EnvironmentObject var topicViewModel: TopicViewModel
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var aIChatViewModel: AIChatViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    
    var body: some View {
        
        ZStack {
            
            Color(hex: "#212737")
                .ignoresSafeArea()
            
            VStack {
                Image("Vector 28654363")
                    .resizable()
                    .frame(height: 200)
                
                Spacer()
                
            }
            
            VStack {
                Text("Choose a topic")
                    .font(.custom("Montserrat-Bold", size: 23))
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding(.top, 73)
            
            
            
            VStack {
                
                ScrollView {
                    
                    Image("Group 19647")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                        .onTapGesture {
                            settingsViewModel.showPaywall = true
                        }
                    
                    HStack {
                        
                        Image("Vector 167098623")
                        //  .padding(.leading, 5)
                        
                        Text("Available messages")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundStyle(.white)
                            .padding(.leading, 7)
                        
                        Spacer()
                        
                        Text("3/3")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal, 10)
                            .background {
                                LinearGradient(colors: [Color(Color(hex: "#24AF5C") ?? .blue),
                                                        Color(Color(hex: "#14A9A4") ?? .blue)],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            }
                        
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                        
                    }
                    .padding(.horizontal, 10)
                    
                    ForEach(Array(topicViewModel.topics.enumerated()), id: \.offset) { index, topic in
                        TopicCell(title: topic.title, iconName: topic.iconName)
                            .onTapGesture {
                                topicViewModel.selectedTopic = topic.title
                                aIChatViewModel.messagesHistory = [
                                    ["role": "system", "content": topic.prompt]
                                ]
                                
                                appRouter.goTo(.freeConversationView)
                                
                                
                                print("\(aIChatViewModel.messagesHistory)")
                            }
                    }
                    
                }
                .scrollIndicators(.hidden)
                
            }
            .padding(.top, 90)
            .padding(.bottom, 177)
            .padding()
            
            
            
            VStack {
                
                Spacer()
                
                HStack {
                    Image("Vector-12")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .padding(.leading, 7)
                    
                    Text("Free Conversation")
                        .font(.custom("Montserrat-Bold", size: 16))
                        .foregroundStyle(.white)
                        .padding(.vertical, 25)
                    
                    
                    Spacer()
                    
                    Image("Vector 13452342")
                        .padding()
                }
                .background {
                    LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue),
                                            Color(Color(hex: "#38A9CF") ?? .blue)],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()
                .padding(.bottom, 100)
                .onTapGesture {
                    if  let freeTopic = topicViewModel.freeTopics.first {
                        topicViewModel.selectedTopic = freeTopic.title
                        aIChatViewModel.messagesHistory = [
                            ["role": "system", "content": freeTopic.prompt]
                        ]
                        
                        appRouter.goTo(.freeConversationView)
                        
                        
                        print("\(aIChatViewModel.messagesHistory)")
                    }
                    
                    
                    
                    // appRouter.goTo(.freeConversationView)
                }
                
            }
            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    @Previewable @StateObject var settingsViewModel = SettingsViewModel()
    TopicsView()
        .environmentObject(TopicViewModel(settings: settingsViewModel))
        .environmentObject(SettingsViewModel())
        .environmentObject(AppRouter())
        .environmentObject(AIChatViewModel())
}
