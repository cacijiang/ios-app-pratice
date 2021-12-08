//
//  ThemeItem.swift
//  Memorize
//
//  Created by Caci Jiang on 5/17/21.
//

import SwiftUI

struct ThemeItem: View {
    @EnvironmentObject var store: ThemeStore
    var theme: Theme
    @Binding var editMode: EditMode
    @State private var editing = false
    
    var body: some View {
        HStack {
            if editMode != .inactive {
                Image(systemName: "pencil.circle").imageScale(.large).foregroundColor(theme.color)
                    .onTapGesture {
                        editing = true
                    }
                    .sheet(isPresented: $editing, onDismiss: {
                        editMode = EditMode.inactive
                    }) {
                        ThemeEditor(theme: theme, editing: $editing)
                    }
            }
            VStack {
                HStack {
                    Text(theme.name).font(Font.system(size: ThemeItemConstants.fontSize)).foregroundColor(theme.color)
                    Spacer()
                }
                Spacer()
                HStack {
                    let sampleEmojis = theme.emojis.count <= ThemeItemConstants.sampleLength ? theme.emojis.joined() : theme.emojis.joined().prefix(ThemeItemConstants.sampleLength) + "..."
                    Text("\(theme.numberOfPairs) pairs from \(sampleEmojis)")
                    Spacer()
                }
            }
        }
    }
    
    private struct ThemeItemConstants {
        static let fontSize: CGFloat = 25
        static let sampleLength: Int = 7
    }
}

//struct ThemeItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeItem()
//    }
//}
