//
//  DailyTapCounter.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 14.12.2025.
//

import Foundation

final class DailyTapCounter: ObservableObject {
    
    @Published var tapsToday: Int = 0
    
    private let maxTapsPerDay = 3
    
    private let tapsKey = "daily_taps_count"
    private let dateKey = "daily_taps_date"
    
    init() {
        load()
    }
    
    var canTap: Bool {
        tapsToday < maxTapsPerDay
    }
    
    func registerTap() {
        guard canTap else { return }
        
        tapsToday += 1
        save()
    }
    
    private func load() {
        let defaults = UserDefaults.standard
        
        let savedDate = defaults.object(forKey: dateKey) as? Date ?? .distantPast
        
        if Calendar.current.isDateInToday(savedDate) {
            tapsToday = defaults.integer(forKey: tapsKey)
        } else {
            tapsToday = 0
            save()
        }
    }
    
    private func save() {
        let defaults = UserDefaults.standard
        defaults.set(tapsToday, forKey: tapsKey)
        defaults.set(Date(), forKey: dateKey)
    }
}
