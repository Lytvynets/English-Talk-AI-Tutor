//
//  SimpleTimerViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.12.2025.
//

import Foundation

final class SimpleTimerViewModel: ObservableObject {
    
    @Published var seconds: Int = 0
    @Published var isRunning = false
    
    private var timer: Timer?
    
    var timeString: String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.seconds += 1
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func toggle() {
        isRunning ? stop() : start()
    }
    
    func reset() {
        stop()
        seconds = 0
    }
}
