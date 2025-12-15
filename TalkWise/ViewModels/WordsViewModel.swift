//
//  WordsViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 03.12.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class WordsViewModel: ObservableObject {
    
    @Published var segments: Segments = .flashcards
    @Published var questionsCount = 5
    @Published var progress: CGFloat = 0.0
    @Published var savedWords: [String] = []
    @Published var learnedWords: [String] = []
    @Published var selectedWord: String = ""
    @Published var selectedWordImgUrl: URL?
    @Published var selectedIndex = 0
    @Published var showAlert = false
    @Published var showSavedAlert = false
    @Published var wordToDelete = ""
    
    
    func saveWord(_ word: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let db = Firestore.firestore()
        
        try await db.collection("users")
            .document(uid)
            .setData([
                "words": FieldValue.arrayUnion([word])
            ], merge: true)

    }
    
    func deleteWord(_ word: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let db = Firestore.firestore()
        
        try await db.collection("users")
            .document(uid)
            .updateData([
                "words": FieldValue.arrayRemove([word])
            ])
    }
    
    
    func saveLearnedWord(_ word: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let db = Firestore.firestore()
        
        try await db.collection("users")
            .document(uid)
            .setData([
                "LearnedWords": FieldValue.arrayUnion([word])
            ], merge: true)
    }
    
    func deleteLearnedWord(_ word: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let db = Firestore.firestore()
        
        try await db.collection("users")
            .document(uid)
            .updateData([
                "LearnedWords": FieldValue.arrayRemove([word])
            ])
    }
    
    
    private func loadWords(wordKey: String) async throws -> [String] {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let doc = try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument()
        
        let data = doc.data()
        let words = data?[wordKey] as? [String] ?? []
        
        return words
    }
    
    
    func fetchSavedWords() {
        Task {
            do {
                let words = try await loadWords(wordKey: "words")
                await MainActor.run {
                    self.savedWords = words
                }
            } catch {
                print("Error loading words: \(error)")
            }
        }
    }
    
    
    func fetchLearnedWords() {
        Task {
            do {
                let words = try await loadWords(wordKey: "LearnedWords")
                await MainActor.run {
                    self.learnedWords = words
                }
            } catch {
                print("Error loading words: \(error)")
            }
        }
    }

    
}
