//
//  BasicSetGame.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import SwiftUI

struct BasicSetGameView: View {
    @ObservedObject var game: BasicSetGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            gameBody
            Spacer()
            HStack{
                deckBody
                Spacer()
                newGameButton
                Spacer()
                discardBody
            }.padding(.horizontal)
        }
    }
    
    @State private var dealt = Set<Int>()
    @State private var discarded = Set<Int>()
    @State private var isFirstDeal = true
    
    private func deal(_ card: BasicSetGame.Card) {
        dealt.insert(card.id)
    }
    
    private func discard(_ card: BasicSetGame.Card) {
        discarded.insert(card.id)
    }
    
    private func dealAnimation(for card: BasicSetGame.Card, index: Int, totalCount: Int) -> Animation {
        let delay = Double(index) * (DrawingConstants.totalDealDuration / Double(totalCount))
        return Animation.easeInOut(duration: DrawingConstants.dealDuration).delay(delay)
    }
    
    private func isUndealt(_ card: BasicSetGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func isUndiscarded(_ card: BasicSetGame.Card) -> Bool {
        return discarded.contains(card.id)
    }
    
    private func zIndex(of card: BasicSetGame.Card, cards: [BasicSetGame.Card]) -> Double {
        -Double(cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func checkUndiscarded() {
        for card in game.matchedCards {
            if !discarded.contains(card.id) {
                discard(card)
            }
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.boardCards,aspectRatio: DrawingConstants.cardAspectRatio,
                    itemCountThreshold: DrawingConstants.itemCountThreshold, content: { card in
            if isUndealt(card) {
                Color.clear
            } else {
                let cardView = CardView(card: card, showBack: false)
                    .padding(4)
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                            checkUndiscarded()
                        }
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card, cards: game.boardCards))
                if card.isChosen {
                    if game.nonMatchFlag {
                        cardView.rotationEffect(.degrees(4)).animation(.linear(duration: 2))
                        .foregroundColor(.red)
                    } else if card.isMatched {
                        withAnimation(.linear(duration: 2)) {
                            cardView.opacity(0.2)
                        }
                    } else {
                        cardView.foregroundColor(.yellow)
                    }
                } else {
                    cardView.foregroundColor(.gray)
                }
            }
        })
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.deck.filter(isUndealt)) { card in
                CardView(card: card, showBack: true)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card, cards: game.deck))
            }
        }
        .frame(width: DrawingConstants.undealWdith, height: DrawingConstants.undealHeight)
        .foregroundColor(DrawingConstants.color)
        .onTapGesture {
            // "deal" cards
            var cardsToBeDealt = Array<BasicSetGame.Card>()
            
            var dealCount: Int
            if isFirstDeal {
                dealCount = game.startsCardsNumber
            } else {
                dealCount = game.setSize
            }
            
            if game.deck.count > 0 {
                for index in 0..<dealCount {
                    cardsToBeDealt.append(game.deck[index])
                }
            } else {
                dealCount = 0
            }
            
            if isFirstDeal {
                game.firstDeal()
                isFirstDeal = false
            } else {
                withAnimation {
                    game.addCards()
                    checkUndiscarded()
                }
            }
            for index in 0..<dealCount {
                let card = cardsToBeDealt[index]
                withAnimation(dealAnimation(for: card, index: index, totalCount: dealCount)) {
                    deal(card)
                }
            }

        }
    }
    
    var discardBody: some View {
        ZStack {
            ForEach(game.matchedCards.filter(isUndiscarded)) { card in
                CardView(card: card, showBack: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
            .foregroundColor(DrawingConstants.color)
        }.frame(width: DrawingConstants.undealWdith, height: DrawingConstants.undealHeight)
    }
    
    var newGameButton: some View {
        Button {
            withAnimation {
                game.newGame()
                isFirstDeal = true
                dealt = []
                discarded = []
            }
        } label: {
            Text("New Game")
                .font(.title2)
                .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                        .stroke(lineWidth: DrawingConstants.lineWidth)
            )
        }
    }
    
    private struct DrawingConstants {
        static let undealHeight: CGFloat = 90
        static let undealWdith: CGFloat = undealHeight * cardAspectRatio
        static let cardAspectRatio: CGFloat = 2/3
        static let color = Color.gray
        static let itemCountThreshold: Int = 30
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 1.0
    }
}

struct BasicSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = BasicSetGame()
        BasicSetGameView(game: game)
            .preferredColorScheme(.dark)
        BasicSetGameView(game: game)
            .preferredColorScheme(.light)
    }
}
