//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Caci Jiang on 3/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
