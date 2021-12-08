//
//  Reminder.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/2/21.
//

import Foundation

struct Reminder: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var hour: Int
    var minute: Int
    var isDone = false
    
    init(id: UUID? = nil, name: String, date: Date, hour: Int, minute: Int) {
        self.id = id ?? UUID()
        self.name = name
        self.date = date
        self.hour = hour
        self.minute = minute
    }
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
