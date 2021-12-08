//
//  macOS.swift
//  CoinTick (macOS)
//
//  Created by Caci Jiang on 6/4/21.
//

import SwiftUI

typealias UIColor = NSColor

extension View {
    func plainButtonOnMacOnly() -> some View {
        self.buttonStyle(PlainButtonStyle()).foregroundColor(.accentColor)
    }
}
