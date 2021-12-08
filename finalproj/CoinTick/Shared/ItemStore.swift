//
//  ItemStore.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/27/21.
//

import SwiftUI
import Combine

class ItemStore: ObservableObject {
    let name: String
    private var autosave: AnyCancellable?
    
    @Published var items = [TodoItem]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ItemStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(items), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedItems = try? JSONDecoder().decode(Array<TodoItem>.self, from: jsonData) {
            items = decodedItems
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        
        if items.isEmpty {
            #if os(iOS)
                let item1 = TodoItem(name: "Filecoin", amount: 1000, color: UIColor.blue, startDate: Date(), endDate: Date())
                let item2 = TodoItem(name: "Bitcoin", amount: 1000, color: UIColor.purple, startDate: Date(), endDate: Date())
                let item3 = TodoItem(name: "Stellar", amount: 500, color: UIColor.gray, startDate: Date(), endDate: Date())
            #else
                let item1 = TodoItem(name: "Filecoin", amount: 1000, startDate: Date(), endDate: Date())
                let item2 = TodoItem(name: "Bitcoin", amount: 1000, startDate: Date(), endDate: Date())
                let item3 = TodoItem(name: "Stellar", amount: 500, startDate: Date(), endDate: Date())
            #endif
            addItem(newItem: item1)
            addItem(newItem: item2)
            addItem(newItem: item3)
            addNote(for: item1, newNote: "Bought $500 on 3/12/2021")
            addNote(for: item1, newNote: "Bought $150")
        }
        
        autosave = $items.sink { items in
            self.storeInUserDefaults()
        }
    }
    
    func item(at index: Int) -> TodoItem {
        let safeIndex = min(max(index, 0), items.count - 1)
        return items[safeIndex]
    }
    
    func addItem(newItem item: TodoItem) {
        items.append(item)
    }
    
    func addNote(for item: TodoItem, newNote note: String) {
        if let index = items.index(matching: item) {
            items[index].notes.insert(note, at: 0)
        }
    }
    
    func setItemName(for item: TodoItem, to newName: String) {
        if let index = items.index(matching: item) {
            items[index].name = newName
        }
    }
    
    func setItemCurrentAmount(for item: TodoItem, to newCurrentAmount: Double) {
        if let index = items.index(matching: item) {
            items[index].currentAmount = newCurrentAmount
        }
    }
    
    #if os(iOS)
    func setItemColor(for item: TodoItem, to newColor: Color) {
        if let index = items.index(matching: item) {
            items[index].rgbColor = UIColor(newColor).rgb
        }
    }
    #endif
    
    func setItemEndDate(for item: TodoItem, to newEndDate: Date) {
        if let index = items.index(matching: item) {
            items[index].endDate = newEndDate
        }
    }
    
    func toggleItemIsDone(for item: TodoItem){
        if let index = items.index(matching: item) {
            let prevIsDone = items[index].isDone
            items[index].isDone = !prevIsDone
        }
    }
}
