//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Caci Jiang on 5/16/21.


import SwiftUI

struct ThemeEditor: View {
    @EnvironmentObject var store: ThemeStore
    @State var theme: Theme
    @Binding var editing: Bool
    
    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Text("Edit \(nameEdit)").font(.headline).padding()
                HStack {
                    Spacer()
                    doneButton
                }
            }
            Divider()
            Form {
                nameSection
                colorSection
                addEmojisSection
                removeEmojiSection
                numberOfPairsSection
            }
        }
        .onAppear {
            nameEdit = theme.name
            colorEdit = theme.color
            pairsEdit = theme.numberOfPairs
        }
    }
    
    var doneButton: some View {
        Button {
            editing = false
        } label: {
            Text("Done").foregroundColor(.blue).padding()
        }
    }
    
    @State private var nameEdit: String = ""
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("", text: $nameEdit, onEditingChanged: { original in
                if !original {
                    store.setThemeName(for: theme, to: nameEdit)
                }
            })
        }
    }
    
    @State private var colorEdit: Color = .clear
    
    var colorSection: some View {
        Section(header: Text("Color")) {
            ColorPicker (
                "Pick a color",
                selection: $colorEdit
            ).foregroundColor(colorEdit)
            .onChange(of: colorEdit, perform: { value in
                store.setThemeColor(for: theme, to: colorEdit)
            })
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }

    func addEmojis(_ emojis: String) {
        withAnimation {
            for emoji in emojis {
                if emoji.isEmoji {
                    store.addEmoji(for: theme, emojiToAdd: String(emoji))
                }
                updateThemeState()
            }
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: ThemeEditorConstants.minimumGridSize))]) {
                    ForEach(theme.emojis, id: \.self) { emoji in
                        Text(emoji)
                            .onTapGesture { theme.emojis.count == ThemeEditorConstants.minimumPairs ? nil :
                            withAnimation {
                                store.removeEmoji(for: theme, emojiToRemove: emoji)
                            }
                            updateThemeState()
                        }
                    }
                }
                .font(.system(size: ThemeEditorConstants.fontSize))
            }
        }
    }
    
    @State var pairsEdit: Int = 0
    
    var numberOfPairsSection: some View {
        Section(header: Text("Number of Pairs")) {
            Stepper(onIncrement: {
                if pairsEdit < theme.emojis.count {
                    pairsEdit += 1
                    store.setNumberOfPairs(for: theme, newNumberOfPairs: pairsEdit)
                }
            }, onDecrement: {
                if pairsEdit > ThemeEditorConstants.minimumPairs {
                    pairsEdit -= 1
                    store.setNumberOfPairs(for: theme, newNumberOfPairs: pairsEdit)
                }
            }) {
                Text("\(pairsEdit) pairs")
            }
        }
    }
    
    private func updateThemeState() {
        theme = store.themes[theme]
        if pairsEdit > theme.emojis.count {
            pairsEdit = theme.emojis.count
        }
    }
    
    private struct ThemeEditorConstants {
        static let fontSize: CGFloat = 40
        static let minimumGridSize: CGFloat = 40
        static let minimumPairs: Int = 2
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    @State static var editing = true
    
    static var previews: some View {
        ThemeEditor(theme: ThemeStore(named: "Preview").theme(at: 4), editing: $editing).environmentObject(ThemeStore(named: "Preview"))
    }
}
