//
//  PexelsImageFetcher.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 02.08.2025.
//

import Foundation

struct PexelsPhoto: Decodable {
    let src: PexelsPhotoSource
}

struct PexelsPhotoSource: Decodable {
    let medium: String
}

struct PexelsSearchResult: Decodable {
    let photos: [PexelsPhoto]
}

class PexelsImageFetcher {
    static let shared = PexelsImageFetcher()
    private let apiKey = AppDefaults.imageAPIKey // 🔑 Встав сюди свій API ключ
    
    func fetchImageURL(for query: String, completion: @escaping (URL?) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(encodedQuery)&per_page=1") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let result = try JSONDecoder().decode(PexelsSearchResult.self, from: data)
                if let urlString = result.photos.first?.src.medium,
                   let imageURL = URL(string: urlString) {
                    completion(imageURL)
                } else {
                    completion(nil)
                }
            } catch {
                print("❌ JSON Decode error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

