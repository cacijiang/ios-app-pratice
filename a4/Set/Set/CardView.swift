//
//  CardView.swift
//  Set
//
//  Created by Caci Jiang on 4/20/21.
//

import SwiftUI

struct CardView: View {
    
    let card: BasicSetGame.Card
    let showBack: Bool

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: CardConstants.cornerRadius)
            if showBack {
                shape.fill(CardConstants.color)
            } else {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: CardConstants.lineWidth)
                CardContentView(cardFeature: card.cardFeature)
                    .padding(.all)
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.gray
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let card = BasicSetGame.Card(cardFeature: BasicFeature(number: .three, symbol: .diamond, coloring: .purple, shading: .shaded), id: 0)
//        VStack {
//            CardView(card: card, showBack: true)
//                .frame(width: 200, height: 200)
//        }
//    }
//}
