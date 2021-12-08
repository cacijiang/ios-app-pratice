//
//  BasicSetGame.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import SwiftUI

class BasicSetGame: ObservableObject {
    typealias Card = SetGame<BasicFeature>.Card
    
    @Published private var model: SetGame<BasicFeature>
    
    private static func createSetGame() -> SetGame<BasicFeature> {
        let startCardsNumber = 12
        
        return SetGame(startCardsNumber: startCardsNumber, isSetFunc: isBasicSet) {
            var features = Array<BasicFeature> ()
            for number in BasicFeature.Number.allCases {
                for symbol in BasicFeature.Symbol.allCases {
                    for coloring in BasicFeature.Coloring.allCases {
                        for shading in BasicFeature.Shading.allCases {
                            features.append(BasicFeature(number: number,
                                                         symbol: symbol,
                                                         coloring: coloring,
                                                         shading: shading))
                        }
                    }
                }
            }
            return features
        }
    }
    
    private static func checkCondition<Content: Equatable>(content1: Content, content2: Content, content3: Content) -> Bool {
        return (content1 == content2 && content2 == content3)
            || (content1 != content2 && content2 != content3 && content1 != content3)
    }
    
    static func isBasicSet(chosenCards: [Card]) -> Bool {
        let card1 = chosenCards[0]
        let card2 = chosenCards[1]
        let card3 = chosenCards[2]
        
        let numberCondition = checkCondition(content1: card1.cardFeature.number,
                                             content2: card2.cardFeature.number,
                                             content3: card3.cardFeature.number)
        let symbolCondition = checkCondition(content1: card1.cardFeature.symbol,
                                             content2: card2.cardFeature.symbol,
                                             content3: card3.cardFeature.symbol)
        let coloringCondition = checkCondition(content1: card1.cardFeature.coloring,
                                               content2: card2.cardFeature.coloring,
                                               content3: card3.cardFeature.coloring)
        let shadingCondition = checkCondition(content1: card1.cardFeature.shading,
                                              content2: card2.cardFeature.shading,
                                              content3: card3.cardFeature.shading)
        
        return numberCondition && symbolCondition && coloringCondition && shadingCondition
    }
    
    init() {
        model = BasicSetGame.createSetGame()
    }
    
    var deck: [Card] {
        model.deck
    }
    
    var boardCards: [Card] {
        model.boardCards
    }
    
    var matchedCards: [Card] {
        model.matchedCards
    }
    
    var setSize: Int {
        model.setSize
    }
    
    var startsCardsNumber: Int {
        model.startCardsNumber
    }
    
    var nonMatchFlag: Bool {
        model.nonMatchFlag
    }
    
    func addCards() {
        model.addCards()
    }
    
    func newGame() {
        model = BasicSetGame.createSetGame()
    }
    
    //MARK: -Intent(s)
    
    func firstDeal() {
        model.firstDeal()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
