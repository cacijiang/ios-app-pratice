//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Caci Jiang on 4/5/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
//    static let emojis = ["🚲", "🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚍", "🚝", "🛰"]
    
    var theme = themes.randomElement()!
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberofPairsOfCards = theme.numberOfPairs ?? Int.random(in: 4..<(emojis.count+1))
        
        return MemoryGame<String> (numberOfPairsOfCards: numberofPairsOfCards) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func newGame() {
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    //MARK: -Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
