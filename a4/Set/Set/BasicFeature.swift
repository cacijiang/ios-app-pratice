//
//  BasicFeature.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import Foundation

struct BasicFeature {
    var number: Number
    var symbol: Symbol
    var coloring: Coloring
    var shading: Shading
    
    enum Number: Int, CaseIterable, Equatable {
        case one = 1, two, three
    }
    
    enum Symbol: CaseIterable, Equatable {
        case diamond
        case rectangle
        case circle
    }
    
    enum Coloring: CaseIterable, Equatable {
        case orange
        case blue
        case purple
    }
    
    enum Shading: CaseIterable, Equatable {
        case stroked
        case shaded
        case filled
    }
}
