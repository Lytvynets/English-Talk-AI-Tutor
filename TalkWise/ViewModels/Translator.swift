//
//  Translator.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.08.2025.
//

import Foundation

class Translator {
    static func translate(text: String, to targetLang: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://libretranslate.de/translate") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = [
            "q": text,
            "source": "en",       // або "auto" для автоматичного визначення
            "target": targetLang, // приклад: "uk" або "fr"
            "format": "text"
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("❌ Translation error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let translatedText = json["translatedText"] as? String {
                completion(translatedText)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

