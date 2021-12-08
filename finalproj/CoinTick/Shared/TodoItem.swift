//
//  TodoItem.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/27/21.
//

import SwiftUI

struct TodoItem: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var totalAmount: Double
    var currentAmount: Double = 0.0
    
    #if os(iOS)
    var rgbColor: UIColor.RGB
    var color: Color {
        Color(rgbColor)
    }
    #endif
    
    var startDate: Date
    var endDate: Date
    var notes = [String]()
    var isDone = false
    
    #if os(iOS)
    init(id: UUID? = nil, name: String, amount: Double, color: UIColor, startDate: Date, endDate: Date) {
        self.id = id ?? UUID()
        self.name = name
        self.totalAmount = amount
        self.rgbColor = color.rgb
        self.startDate = startDate
        self.endDate = endDate
    }
    #else
    init(id: UUID? = nil, name: String, amount: Double, startDate: Date, endDate: Date) {
        self.id = id ?? UUID()
        self.name = name
        self.totalAmount = amount
        self.startDate = startDate
        self.endDate = endDate
    }
    #endif
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
