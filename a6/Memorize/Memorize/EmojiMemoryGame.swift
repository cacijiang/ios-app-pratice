//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Caci Jiang on 4/5/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    @EnvironmentObject var store: ThemeStore
    
    var theme: Theme
    
    private static let emojis = ["🚲", "🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚍", "🚝", "🛰"]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberofPairsOfCards = theme.numberOfPairs
        
        return MemoryGame<String> (numberOfPairsOfCards: numberofPairsOfCards) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    //MARK: -Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
