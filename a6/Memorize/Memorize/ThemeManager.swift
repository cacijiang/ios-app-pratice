//
//  ThemeManager.swift
//  Memorize
//
//  Created by Caci Jiang on 5/16/21.
//

import SwiftUI

struct ThemeManager: View {
    @EnvironmentObject var store: ThemeStore
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                        ThemeItem(theme: theme, editMode: $editMode)
                    }
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Manage Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            store.insertDefaultTheme()
                        }
                    } label: {
                        Image(systemName: "plus").imageScale(.large)
                    }
                }
                ToolbarItem { EditButton() }
            }
            .environment(\.editMode, $editMode)
        }
    }
}

struct ThemeManager_Previews: PreviewProvider {
    static var previews: some View {
        ThemeManager()
            .environmentObject(ThemeStore(named: "Preview"))
    }
}
