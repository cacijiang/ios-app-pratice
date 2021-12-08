//
//  CardView.swift
//  Set
//
//  Created by Caci Jiang on 4/20/21.
//

import SwiftUI

struct CardView: View {
    let card: BasicSetGame.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: DrawingConstants.lineWidth)
            CardContentView(cardFeature: card.cardFeature)
                .padding(.all)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let card = BasicSetGame.Card(cardFeature: BasicFeature(number: .three, symbol: .diamond, coloring: .purple, shading: .shaded), id: 0)
//        VStack {
//            CardView(card: card)
//                .frame(width: 200, height: 200)
//        }
//    }
//}
