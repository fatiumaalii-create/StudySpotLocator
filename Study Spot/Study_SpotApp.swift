//
//  Study_SpotApp.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//

import SwiftUI
import SwiftData
import UserNotifications

// ---------------------------------------------------------
// Unit 4.5: SwiftData model (same pattern as FoodOrder / Book in the practice)
// ---------------------------------------------------------
@Model
class StudySpot {
    var id: UUID
    var name: String
    var notes: String
    var icon: String
    var rating: Int                  // 0 = not rated yet, 1...5 stars
    var hasCoffee: Bool
    var drinkBooked: String          // "No drink" or the drink name
    var bookingSaved: Bool
    var reminderMinutes: Int         // 0 = no reminder saved
    var reminderNotification: Bool

    init(name: String, notes: String, icon: String, rating: Int, hasCoffee: Bool) {
        self.id = UUID()
        self.name = name
        self.notes = notes
        self.icon = icon
        self.rating = rating
        self.hasCoffee = hasCoffee
        self.drinkBooked = "No drink"
        self.bookingSaved = false
        self.reminderMinutes = 0
        self.reminderNotification = false
    }
}

// Unit 3.3: show the notification banner even when the app is open
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                    @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

let notificationDelegate = NotificationDelegate()

@main
struct Study_SpotApp: App {

    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: StudySpot.self)      // Unit 4.5: SwiftData
    }
}

