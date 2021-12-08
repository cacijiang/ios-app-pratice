//
//  Diamond.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let leftVertice = CGPoint(x: rect.minX, y: rect.midY)
        let bottomVertice = CGPoint(x: rect.midX, y: rect.maxY)
        let rightVertice = CGPoint(x: rect.maxX, y: rect.midY)
        let topVertice = CGPoint(x: rect.midX, y: rect.minY)
        p.move(to: leftVertice)
        p.addLine(to: bottomVertice)
        p.addLine(to: rightVertice)
        p.addLine(to: topVertice)
        p.addLine(to: leftVertice)
        return p
    }
}
