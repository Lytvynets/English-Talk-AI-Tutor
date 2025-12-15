//
//  OpenAITranslator.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 10.12.2025.
//

import Foundation
import FirebaseAuth

struct OpenAITranslator {
    static var shared = OpenAITranslator()
    
    private var cache: [String: String] = [:]
    
    
    static func makeIPA(for rawWord: String, completion: @escaping (String?) -> Void) {
        
        
        
        let word = rawWord.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if let cached = shared.cache[word] {
            completion(cached)
            return
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(nil); return
        }
        
        let systemPrompt =
        """
        You are a dictionary bot. Provide only the IPA transcription for the given English word (American English) in square brackets, for example: [ˈæpəl]. Do not add any extra text.
        """
        
        let messages: [[String: String]] = [
            ["role": "system", "content": systemPrompt],
            ["role": "user", "content": word]
            //["role": "user", "content": word]
        ]
        
        let json: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0,
            "max_tokens": 30
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // <- ЗВЕРНИ УВАГУ: тут нема зайвої дужки
        request.addValue("Bearer \(AppDefaults.openAIKey)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json)
        } catch {
            print("JSON serialization error:", error)
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error:", error)
                completion(nil); return
            }
            
            if let http = response as? HTTPURLResponse {
                guard (200...299).contains(http.statusCode) else {
                    // Спробуй вивести тіло відповіді для дебагу
                    if let d = data, let body = String(data: d, encoding: .utf8) {
                        print("OpenAI returned status:", http.statusCode, "body:", body)
                    } else {
                        print("OpenAI returned status:", http.statusCode)
                    }
                    completion(nil)
                    return
                }
            }
            
            guard let data = data else {
                completion(nil); return
            }
            
            // Парсимо відповідь
            if let responseObj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                // Дебаг: виводимо повну відповідь (при розробці можна коментувати)
                // print("Full response:", responseObj)
                
                if let choices = responseObj["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    let ipa = content.trimmingCharacters(in: .whitespacesAndNewlines)
                    // простий захист: залишити тільки те, що в квадратних дужках, якщо модель додала щось зайве
                    if let range = ipa.range(of: "\\[.*\\]", options: .regularExpression) {
                        let bracketed = String(ipa[range])
                        shared.cache[word] = bracketed
                        completion(bracketed)
                    } else {
                        // якщо немає квадратних дужок, повернемо весь рядок (або nil)
                        shared.cache[word] = ipa
                        completion(ipa)
                    }
                    return
                } else {
                    print("Parsing error: choices/message not found in response.")
                }
            } else {
                let text = String(data: data, encoding: .utf8) ?? "<non-utf8 response>"
                print("Failed to parse JSON. Raw response:", text)
            }
            
            completion(nil)
        }.resume()
        
    }
    
    
    //   static func makeIPA(for word: String, completion: @escaping (String?) -> Void) {
    //        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
    //            completion(nil)
    //            return
    //        }
    //
    //        let systemPrompt =
    //        """
    //        You are a dictionary bot. Provide only the IPA transcription for the word "\(word)" in square brackets, for American English. Do not give explanations or examples. Output must be like: [ˈæpəl].
    //        """
    //
    //        let messages: [[String: String]] = [
    //            ["role": "system", "content": systemPrompt]
    //        ]
    //
    //        let json: [String: Any] = [
    //            "model": "gpt-4o-mini", // або gpt-3.5, можна поставити дешеву модель
    //            "messages": messages,
    //            "temperature": 0,
    //            "max_tokens": 20
    //        ]
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.addValue("Bearer \(AppDefaults.openAIKey))", forHTTPHeaderField: "Authorization")
    //        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
    //
    //        URLSession.shared.dataTask(with: request) { data, _, error in
    //            guard let data = data, error == nil else {
    //                completion(nil)
    //                return
    //            }
    //
    //            if let response = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
    //               let choices = response["choices"] as? [[String: Any]],
    //               let message = choices.first?["message"] as? [String: Any],
    //               let content = message["content"] as? String
    //            {
    //                let ipa = content.trimmingCharacters(in: .whitespacesAndNewlines)
    //                completion(ipa)
    //            } else {
    //                completion(nil)
    //            }
    //        }.resume()
    //    }
    
    
    static func makeSentence(with word: String, completion: @escaping (String?) -> Void) {
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(nil)
            return
        }
        
        let systemPrompt =
          """
          You are an English teacher. Create a very simple sentence in English using the word \"\(word)\". Sentence must be short and fit in one line. Avoid commas.
          """
        
        let messages: [[String: String]] = [
            ["role": "system", "content": systemPrompt],
            ["role": "user", "content": word]
        ]
        
        let json: [String: Any] = [
            "model": "gpt-4o-mini", // або gpt-3.5, або інша — як хочеш
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 30
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(AppDefaults.openAIKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let response = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = response["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String
            {
                completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                completion(nil)
            }
        }.resume()
        
    }
    
    
    static func translate(text: String, to targetLang: String, completion: @escaping (String?) -> Void) {
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(nil)
            return
        }
        
        let messages: [[String: String]] = [
            ["role": "system", "content": "You are a translator. Translate everything into \(targetLang)."],
            ["role": "user", "content": text]
        ]
        
        let json: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(AppDefaults.openAIKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let response = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = response["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                completion(nil)
            }
        }.resume()
        
    }
}
