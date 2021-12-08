//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Caci Jiang on 3/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeManager().environmentObject(themeStore)
        }
    }
}
