//
//  CardContentView.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import SwiftUI

struct CardContentView: View {
    var cardFeature: BasicFeature
    
    struct SymbolView: Shape {
        var symbol: BasicFeature.Symbol
        
        func path(in rect: CGRect) -> Path {
            switch symbol {
                case .circle: return Circle().path(in: rect)
            case .rectangle: return RoundedRectangle(cornerRadius: DrawingConstants.symbolCornerRadius).path(in: rect)
                case .diamond: return Diamond().path(in: rect)
            }
        }
    }
    
    private var symbolView: SymbolView {
        return SymbolView(symbol: cardFeature.symbol)
    }
    
    private var coloring: Color {
        switch cardFeature.coloring {
        case .orange: return .orange
            case .blue: return .blue
            case .purple: return .purple
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<cardFeature.number.rawValue, id: \.self) { _ in
                ZStack{
                    if cardFeature.shading == .stroked {
                        symbolView.fill().foregroundColor(.white)
                    } else if cardFeature.shading == .shaded {
                        symbolView.fill().opacity(DrawingConstants.shadingOpacity)
                    } else {
                        symbolView.fill()
                    }
                    symbolView.stroke(lineWidth: DrawingConstants.lineWidth)
                }
                .foregroundColor(coloring)
                .aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
            }
        }
    }
    
    private struct DrawingConstants {
        static let symbolAspectRatio: CGFloat = 2
        static let symbolCornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let shadingOpacity: Double = 0.4
    }
}

//struct CardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardContentView(cardFeature: BasicFeature(number: .one, symbol: .rectangle, coloring: .purple, shading: .shaded))
//            .frame(width: 200, height: 200)
//    }
//}
