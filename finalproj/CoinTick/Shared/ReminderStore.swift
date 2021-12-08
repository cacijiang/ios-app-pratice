//
//  ReminderStore.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/2/21.
//

import SwiftUI
import Combine

class ReminderStore: ObservableObject {
    let name: String
    private var autosave: AnyCancellable?
    
    @Published var reminders = [Reminder]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ReminderStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(reminders), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedReminders = try? JSONDecoder().decode(Array<Reminder>.self, from: jsonData) {
            reminders = decodedReminders
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        
        if reminders.isEmpty {
            let reminder1 = Reminder(name: "Sell Filcoin", date: Date(), hour: 10, minute: 0)
            let reminder2 = Reminder(name: "Buy Etheruem", date: Date(), hour: 14, minute: 30)
            let reminder3 = Reminder(name: "Buy Bitcoin", date: Date(), hour: 20, minute: 45)
            addReminder(newReminder: reminder1)
            addReminder(newReminder: reminder2)
            addReminder(newReminder: reminder3)
        }
        
        autosave = $reminders.sink { reminders in
            self.storeInUserDefaults()
        }
    }
    
    func addReminder(newReminder reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func completeReminder(for reminderId: UUID) {
        if let index = reminders.firstIndex(where: { $0.id == reminderId }) {
            reminders[index].isDone = true
        }
    }
    
    func removeReminder(for reminderId: UUID){
        if let index = reminders.firstIndex(where: { $0.id == reminderId }) {
            reminders.remove(at: index)
        }
    }
}
