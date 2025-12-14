//
//  AIChatViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 28.07.2025.
//

import Foundation
import AVFoundation
import Speech
import SwiftUI

//struct ChatMessage: Identifiable {
//    let id = UUID()
//    let role: String // "user" або "assistant"
//    let content: String
//}


class AIChatViewModel: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
        
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let synthesizer = AVSpeechSynthesizer()
    private var avPlayer: AVPlayer?
    
    @Published var transcribedText = ""
    @Published var aiResponse = ""
    @Published var isRecording = false
    @Published var messageIsSend = false
    @Published var showTranslateWord = false
    @Published var translateWord = ""
    @Published var translatedWord = ""
    @Published var translateOnlyWord = true
//    static var prompt = "You are a friendly English tutor. When the user makes mistakes in grammar or vocabulary, correct them and explain the correction simply."
    
    // Сюди треба додати вибрану тему
//    @Published var messagesHistory: [[String: String]] = [
//        ["role": "system", "content": "You are a friendly English tutor. When the user makes mistakes in grammar or vocabulary, correct them and explain the correction simply."]
//    ]
    
    
    @Published var messagesHistory: [[String: String]] = [
        ["role": "system", "content": "prompt"]
    ]
    
    
    func toggleRecording() {
        messageIsSend = false
        isRecording ? stopRecording() : startRecording()
    }
    
    
    func startRecording() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            guard authStatus == .authorized else {
                print("Speech recognition not authorized")
                return
            }
            
            DispatchQueue.main.async {
                self.transcribedText = ""
                self.aiResponse = ""
                self.isRecording = true
                
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                } catch {
                    print("Failed to set audio session category: \(error)")
                    return
                }
                
                if self.audioEngine.isRunning {
                    self.audioEngine.stop()
                    self.audioEngine.inputNode.removeTap(onBus: 0)
                    self.audioEngine.reset()
                }
                
                let inputNode = self.audioEngine.inputNode
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                
                self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                guard let recognitionRequest = self.recognitionRequest else {
                    print("Failed to create recognition request")
                    return
                }
                
                self.recognitionTask?.cancel()
                self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                    if let result = result {
                        self.transcribedText = result.bestTranscription.formattedString
                    }
                    
                    if let error = error {
                        print("Recognition error: \(error.localizedDescription)")
                        self.stopRecording()
                    }
                }
                
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                    recognitionRequest.append(buffer)
                }
                
                do {
                    self.audioEngine.prepare()
                    try self.audioEngine.start()
                } catch {
                    print("Audio engine failed to start: \(error)")
                }
            }
        }
    }
    
    
    func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
        }
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
        isRecording = false
        if !messageIsSend {
            sendToOpenAI()
            messageIsSend = true
        }
       
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    
    func sendToOpenAI() {
        guard !transcribedText.isEmpty else { return }

        // Додаємо останнє повідомлення користувача до історії need to add user id
        messagesHistory.append(["role": "user", "content": transcribedText])

        let payload: [String: Any] = [
            "model": "gpt-4o",
            "messages": messagesHistory
        ]

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions"),
              let httpBody = try? JSONSerialization.data(withJSONObject: payload) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(AppDefaults.openAIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Request error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ No data received")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let choices = json?["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {

                    DispatchQueue.main.async {
                        self.aiResponse = content

                        // Додаємо відповідь AI до історії
                        self.messagesHistory.append(["role": "assistant", "content": content])

                        self.speakWithOpenAITTS(text: content) { url in
                            if let url = url {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.playAudio(from: url)
                                }
                            }
                        }
                    }
                } else {
                    print("❌ Unexpected JSON format: \(json ?? [:])")
                }
            } catch {
                print("❌ JSON parsing error: \(error.localizedDescription)")
            }
        }.resume()
    }

    
    
//    private func sendToOpenAI() {
//        guard !transcribedText.isEmpty else { return }
//        
//        let systemPrompt = "You are a friendly English tutor. When the user makes mistakes in grammar or vocabulary, correct them and explain the correction simply."
//        
//        let messages: [[String: String]] = [
//            ["role": "system", "content": systemPrompt],
//            ["role": "user", "content": transcribedText]
//        ]
//        
//        let payload: [String: Any] = [
//            "model": "gpt-4o",
//            "messages": messages
//        ]
//        
//        guard let url = URL(string: "https://api.openai.com/v1/chat/completions"),
//              let httpBody = try? JSONSerialization.data(withJSONObject: payload) else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(AppDefaults.openAIKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = httpBody
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("❌ Request error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse {
//                print("📡 Status Code: \(httpResponse.statusCode)")
//            }
//            
//            guard let data = data else {
//                print("❌ No data received")
//                return
//            }
//            
//            if let raw = String(data: data, encoding: .utf8) {
//                print("📦 Raw JSON: \(raw)")
//            }
//            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                
//                if let choices = json?["choices"] as? [[String: Any]],
//                   let message = choices.first?["message"] as? [String: Any],
//                   let content = message["content"] as? String {
//                    
//                    DispatchQueue.main.async {
//                        self.aiResponse = content
//                        
//                        self.speakWithOpenAITTS(text: "\(content)") { url in
//                            if let url = url {
//                                print("URL: \(url)")
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                    self.playAudio(from: url)
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    print("❌ Unexpected JSON format: \(json ?? [:])")
//                }
//            } catch {
//                print("❌ JSON parsing error: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
    
    
    func speakWithOpenAITTS(text: String, completion: @escaping (URL?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/audio/speech")!
        let voice = UserDefaults.standard.string(forKey: "selectedVoice") ?? "nova"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(AppDefaults.openAIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "tts-1",
            "input": text,
            "voice": voice,
//            "voice": "nova", // або nova, echo, alloy...
            "response_format": "mp3"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("❌ TTS error: \(error?.localizedDescription ?? "unknown")")
                completion(nil)
                return
            }
            
            let tmpFile = FileManager.default.temporaryDirectory.appendingPathComponent("openai_speech.mp3")
            do {
                try data.write(to: tmpFile)
                completion(tmpFile)
            } catch {
                print("❌ File write error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    
    func playAudio(from url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            avPlayer = AVPlayer(url: url)
            avPlayer?.play()
            print("▶️ Відтворення через AVPlayer")
        } catch {
            print("❌ AVAudioSession error: \(error.localizedDescription)")
        }
    }
    
    
    func speak(_ text: String) {
        print("🔊 Озвучую: \(text)")
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
