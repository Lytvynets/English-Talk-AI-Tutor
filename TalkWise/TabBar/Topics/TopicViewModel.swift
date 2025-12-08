//
//  TopicViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 03.08.2025.
//

import Foundation

class TopicViewModel: ObservableObject {
    
    @Published var freeTopics: [TopicModel] = [TopicModel(title: "Free topic",
                                                          prompt: "You are a friendly English tutor. When the user makes mistakes in grammar or vocabulary, correct them and explain the correction simply.",
                                                          iconName: "Vector-12")]
    
    @Published var topics: [TopicModel] = [TopicModel(title: "Daily Routine",
                                                      prompt: "You are a friendly English tutor. Talk about daily routines using simple English. Ask what the user does in the morning, afternoon, and evening. If the user makes a mistake, gently correct it and explain in a simple way.",
                                                      iconName: "Vector5809728397602"),
                                           TopicModel(title: "Food and Drinks",
                                                      prompt: "You are an English teacher helping a student learn how to talk about food. Use short, easy sentences. Ask what the user likes to eat and drink. Correct any mistakes clearly and kindly.",
                                                      iconName: "Group 7171"),
                                           TopicModel(title: "Hobbies and Free Time",
                                                      prompt: "Speak like a beginner English tutor. Ask the user about their hobbies and how they spend their free time. Speak slowly and correct grammar or vocabulary mistakes with a simple explanation.",
                                                      iconName: "Vector-2"),
                                           TopicModel(title: "Shopping",
                                                      prompt: "Help the user talk about shopping in English. Ask what they buy, where they go shopping, and how often. Use short, simple phrases and correct mistakes clearly.",
                                                      iconName: "Vector-3"),
                                           TopicModel(title: "Travel",
                                                      prompt: "Talk about travel using easy English. Ask the user where they have been and where they want to go. If they make grammar mistakes, correct them in a simple and friendly way.",
                                                      iconName: "Vector-4"),
                                           TopicModel(title: "Weather",
                                                      prompt: "Ask the user about the weather today. Use short sentences and easy words. Correct their grammar only if they make a mistake, and explain it clearly.",
                                                      iconName: "Vector-5"),
                                           TopicModel(title: "Family and Friends",
                                                      prompt: "Talk with the user about their family and friends. Use beginner-level English. Gently correct mistakes and give clear examples if needed.",
                                                      iconName: "Group 7172"),
                                           TopicModel(title: "Work and Jobs",
                                                      prompt: "Ask the user about their job or what they want to do in the future. Keep the conversation simple. Correct errors in a helpful and kind way.",
                                                      iconName: "Vector-6"),
                                           TopicModel(title: "School and Education",
                                                      prompt: "Help the user talk about school or studying. Use short sentences and beginner vocabulary. If they make a mistake, correct it clearly and simply.",
                                                      iconName: "Vector-7"),
                                           TopicModel(title: "Health and Body",
                                                      prompt: "Speak about health, body parts, and feeling sick using easy English. Ask how the user feels. Fix grammar mistakes gently with an explanation.",
                                                      iconName: "Vector-8"),
                                           TopicModel(title: "Feelings and Emotions",
                                                      prompt: "Help the user describe how they feel using simple words. Ask follow-up questions. Correct their sentences if they make mistakes and explain why.",
                                                      iconName: "Vector-9"),
                                           TopicModel(title: "House and Home",
                                                      prompt: "Ask the user about their house or apartment. Use short, basic English sentences. Correct mistakes with easy-to-understand feedback.",
                                                      iconName: "Vector-10"),
                                           TopicModel(title: "Transportation",
                                                      prompt: "Talk about transportation (buses, trains, cars). Ask how the user usually travels. Use simple English and correct mistakes kindly.",
                                                      iconName: "Group3243242463"),
                                           TopicModel(title: "Technology and Gadgets",
                                                      prompt: "Ask the user about their phone, computer, or internet habits. Use simple English and correct mistakes clearly.",
                                                      iconName: "Group 7173"),
                                           TopicModel(title: "Making Plans",
                                                      prompt: "Help the user talk about plans for today, tomorrow, or the weekend. Use very simple English. Gently fix grammar and explain mistakes clearly.",
                                                      iconName: "Vector-11"),
                                           
    ]
    
    
    
    
    
}
