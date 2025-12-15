//
//  NotificationManager.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 14.12.2025.
//

import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    private let notificationId = "daily_english_notification"
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { _, _ in }
    }
    
    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time to practice 🇬🇧"
        content.body = "Spend 5 minutes learning English today"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: notificationId,
            content: content,
            trigger: trigger
        )
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notificationId])
        center.add(request)
    }
    
    func disableNotifications() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [notificationId])
    }
}
