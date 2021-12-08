//
//  ThemeStore.swift
//  Memorize
//
//  Created by Caci Jiang on 5/16/21.
//

import SwiftUI
import Combine

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var emojis: [String]
    var rgbColor: UIColor.RGB
    var color: Color {
        Color(rgbColor)
    }
    var numberOfPairs: Int
    var id: Int
    
    init(name: String, emojis: [String], color: UIColor, numberOfParis: Int, id: Int) {
        self.name = name
        self.emojis = emojis
        self.rgbColor = color.rgb
        self.numberOfPairs = numberOfParis
        self.id = id
    }
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

class ThemeStore: ObservableObject {
    let name: String
    private var autosave: AnyCancellable?
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()

        if themes.isEmpty {
            insertTheme(named: "Vehicles", emojis: ["🚲", "🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚍", "🚝", "🛰"], color: UIColor.red, numberOfPairs: 8)
            insertTheme(named: "Sports", emojis: ["⚽️", "🏀", "🏈", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🏹", "🥊", "🤿"], color: UIColor.blue, numberOfPairs: 8)
            insertTheme(named: "Animals", emojis: ["🐭", "🐮", "🐯", "🐰", "🐵", "🐔", "🐶", "🐷", "🐲", "🐍", "🐴", "🐑"], color: UIColor.orange, numberOfPairs: 6)
            insertTheme(named: "Snacks", emojis:  ["🥮", "🍢", "🍡", "🍧", "🍨", "🍦", "🥧", "🧁", "🍰", "🍮", "🍭", "🍬", "🍫", "🍿", "🍩", "🍪"], color: UIColor.yellow, numberOfPairs: 6)
            insertTheme(named: "Drinks", emojis: ["🥛", "🍼", "🫖", "☕️", "🍵", "🧃", "🥤", "🧋", "🍶", "🍺", "🍻", "🥂", "🍷", "🥃", "🍸", "🍹", "🧉", "🍾"], color: UIColor.brown, numberOfPairs: 6)
            insertTheme(named: "Fruits", emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"], color: UIColor.green, numberOfPairs: 8)
        }
        
        autosave = $themes.sink { themes in
            self.storeInUserDefaults()
        }
    }
    
    // MARK: - Intent
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
           themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: [String], color: UIColor, numberOfPairs: Int, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis, color: color, numberOfParis: numberOfPairs, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
    
    func insertDefaultTheme() {
        insertTheme(named: "New", emojis: ["😷", "🤧"], color: UIColor.blue, numberOfPairs: 2)
    }
    
    func setThemeName(for theme: Theme, to newName: String) {
        if let index = themes.index(matching: theme) {
            themes[index].name = newName
        }
    }
    
    func setThemeColor(for theme: Theme, to newColor: Color) {
        if let index = themes.index(matching: theme) {
            themes[index].rgbColor = UIColor(newColor).rgb
        }
    }
    
    func addEmoji(for theme: Theme, emojiToAdd emoji: String) {
        if let index = themes.index(matching: theme), !themes[index].emojis.contains(emoji) {
            themes[index].emojis.append(emoji)
        }
    }
    
    func removeEmoji(for theme: Theme, emojiToRemove emoji: String) {
        if let index = themes.index(matching: theme), themes[index].emojis.contains(emoji) {
            themes[index].emojis = themes[index].emojis.filter { $0 != emoji }
        }
    }
    
    func setNumberOfPairs(for theme: Theme, newNumberOfPairs: Int) {
        if let index = themes.index(matching: theme) {
            themes[index].numberOfPairs = newNumberOfPairs
        }
    }
}
