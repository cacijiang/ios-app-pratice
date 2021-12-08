//
//  SetApp.swift
//  Set
//
//  Created by Caci Jiang on 4/18/21.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = BasicSetGame()
    
    var body: some Scene {
        WindowGroup {
            BasicSetGameView(game: game)
        }
    }
}
