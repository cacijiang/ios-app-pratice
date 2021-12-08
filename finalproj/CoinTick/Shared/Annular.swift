//
//  Annular.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/28/21.
//

import SwiftUI

struct Annular: View {
    let color: Color
    let currentAmount: Double
    let originalAmount: Double
   @State var percent = 0
    
    init(color: Color, currentAmount: Double, originalAmount: Double) {
        self.color = color
        self.currentAmount = currentAmount
        self.originalAmount = originalAmount
    }
    
    var body: some View {
        ZStack {
            Circle().foregroundColor(color).opacity(0.2)
                .frame(width: 150, height: 150)
            
            Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: Double(-90 + percent * 360 / 100))).foregroundColor(color)
                .frame(width: 150, height: 150)
            
            let circle = Circle().frame(width: 100, height: 100)
            #if os(iOS)
                circle.foregroundColor(Color(UIColor.systemBackground))
            #else
                circle.foregroundColor(Color(NSColor.windowBackgroundColor))
            #endif

            Text("\(percent) %").font(.title3).foregroundColor(color)
        }
        .onAppear {
            withAnimation(.linear(duration: 2)) {
                percent = Int((currentAmount * 100 / originalAmount).rounded())
            }
        }
    }
}

struct Annular_Previews: PreviewProvider {
    static var previews: some View {
        Annular(color: .red, currentAmount: 500.0, originalAmount: 1000.0)
    }
}
