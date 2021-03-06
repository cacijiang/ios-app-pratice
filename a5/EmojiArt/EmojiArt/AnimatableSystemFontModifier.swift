//
//  AnimatableSystemFontModifier.swift
//  EmojiArt
//
//  Created by Caci Jiang on 5/3/21.
//

import SwiftUI

struct AnimatableSystemFontModifier: AnimatableModifier {
    
    var size: CGFloat
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content.font(.system(size: size))
    }
}

extension View {
    func font(animatableSize size: CGFloat) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size))
    }
}
