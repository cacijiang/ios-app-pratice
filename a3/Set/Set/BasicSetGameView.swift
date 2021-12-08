//
//  BasicSetGame.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import SwiftUI

struct BasicSetGameView: View {
    // pre-defined card contents for different themes
    @ObservedObject var game: BasicSetGame
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.boardCards,
                        aspectRatio: DrawingConstants.cardAspectRatio,
                        itemCountThreshold: DrawingConstants.itemCountThreshold,
                        content: { card in
                let cardView = CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
                if card.isChosen {
                    if game.nonMatchFlag {
                        cardView.foregroundColor(.red)
                    } else if card.isMatched {
                        cardView.foregroundColor(.green)
                    } else {
                        cardView.foregroundColor(.yellow)
                    }
                } else {
                    cardView.foregroundColor(.gray)
                }
            })
            .padding(.horizontal)
            Spacer()
            HStack{
                if game.deck.count == 0 {
                    addCardButton.foregroundColor(.gray)
                } else {
                    addCardButton
                }
                Spacer()
                newGameButton
            }.padding(.horizontal)
        }
    }
    
    var addCardButton: some View {
        Button {
            game.addCards()
        } label: {
            Text("Add 3+ Cards")
                .font(.title2)
                .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                        .stroke(lineWidth: DrawingConstants.lineWidth)
            )
        }
    }
    
    var newGameButton: some View {
        Button {
            game.newGame()
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
        static let cardAspectRatio: CGFloat = 2/3
        static let itemCountThreshold: Int = 30
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
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
