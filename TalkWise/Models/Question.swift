//
//  Question.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 12.12.2025.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let imageURL: URL
    let correctWord: String
    let options: [String]
}
