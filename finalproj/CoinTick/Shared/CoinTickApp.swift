//
//  CoinTickApp.swift
//  Shared
//
//  Created by Caci Jiang on 6/4/21.
//

import SwiftUI

@main
struct CoinTickApp: App {
    @StateObject var itemStore = ItemStore(named: "R-2 List")
    @StateObject var reminderStore = ReminderStore(named: "Coin Reminders")
    @StateObject var progress = UserProgress()
    
    var body: some Scene {
        WindowGroup {
            CoinTickView(progress: progress)
                .environmentObject(itemStore)
                .environmentObject(reminderStore)
        }
    }
}
