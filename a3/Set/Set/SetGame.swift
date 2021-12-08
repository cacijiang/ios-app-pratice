//
//  SetGame.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import Foundation

struct SetGame<CardFeature> {
    private(set) var deck: [Card]
    private(set) var boardCards: [Card]
    private(set) var matchedCards: [Card]
    private(set) var nonMatchFlag: Bool
    
    private var chosenCards: [Card] {
        boardCards.filter{ $0.isChosen }
    }
    
    private var isSet: ([Card]) -> Bool
    
    init(startCardsNumber: Int, isSetFunc: @escaping ([Card]) -> Bool, createAllFeatures: () -> [CardFeature]) {
        deck = []
        boardCards = []
        let allFeatures = createAllFeatures()
        for index in 0..<allFeatures.count {
            deck.append(Card(cardFeature: allFeatures[index], id: index))
        }
        deck.shuffle()
        for index in 0..<startCardsNumber {
            boardCards.append(deck[index])
        }
        deck.removeFirst(startCardsNumber)
        matchedCards = []
        nonMatchFlag = false
        isSet = isSetFunc
//        print("SetGame init() \(deck.count) cards in deck; \(boardCards.count) - board cards; \(matchedCards.count) - matched cards")
    }
    
    mutating func choose(_ card: Card) {
        preCheckSet()
        
        if chosenCards.count < setSize {
            if let chosenIndex = boardCards.firstIndex(where: { $0.id == card.id }) {
                boardCards[chosenIndex].isChosen.toggle()
            }
        }
        
        postCheckSet()
//        print("SetGame choose() \(deck.count) cards in deck; \(boardCards.count) - board cards; \(matchedCards.count) - matched cards")
    }
    
    private mutating func preCheckSet() {
        if chosenCards.count == setSize {
            let chosenIds = getChosenIds()
            if !nonMatchFlag {
                var replaceIndices = Array<Int> ()
                for index in boardCards.indices {
                    if chosenIds.contains(boardCards[index].id) {
                        replaceIndices.append(index)
                        matchedCards.append(boardCards[index])
                    }
                }
                if deck.count >= setSize {
                    for index in 0..<setSize {
                        boardCards[replaceIndices[index]] = deck[index]
                    }
                    deck.removeFirst(setSize)
                } else {
                    for id in chosenIds {
                        boardCards = boardCards.filter { $0.id != id }
                    }
                }
            } else {
                for index in boardCards.indices {
                    if chosenIds.contains(boardCards[index].id) {
                        boardCards[index].isChosen.toggle()
                    }
                }
                nonMatchFlag = false
            }
        }
    }
    
    private mutating func postCheckSet() {
        if chosenCards.count == setSize {
            let chosenIds = getChosenIds()
            if isSet(chosenCards) {
                // change to green
                for index in boardCards.indices {
                    if chosenIds.contains(boardCards[index].id) {
                        boardCards[index].isMatched = true
                    }
                }
            } else {
                // change to red
                nonMatchFlag = true
            }
        }
    }
    
    mutating func addCards() {
        if deck.count >= setSize {
            for index in 0..<setSize {
                boardCards.append(deck[index])
            }
            deck.removeFirst(setSize)
        }
//        print("SetGame addCards() \(deck.count) cards in deck; \(boardCards.count) - board cards; \(matchedCards.count) - matched cards")
    }
    
    private func getChosenIds() -> [Int] {
        var chosenIds = Array<Int> ()
        for card in chosenCards {
            chosenIds.append(card.id)
        }
        return chosenIds
    }
    
    struct Card: Identifiable {
        var isMatched = false
        var isChosen = false
        let cardFeature: CardFeature
        let id: Int
    }
    
    private let setSize = 3
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}

