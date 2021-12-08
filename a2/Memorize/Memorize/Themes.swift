//
//  Themes.swift
//  Memorize
//
//  Created by Caci Jiang on 4/11/21.
//

import SwiftUI

struct Theme {
    var name: String
    var color: Color
    var emojis: Array<String>
    var numberOfPairs: Int?
}

let themes = [Theme(name: "Vehicles",
                    color: .red,
                    emojis: ["🚲", "🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚍", "🚝", "🛰"],
                    numberOfPairs: 8),
              Theme(name: "Animals",
                    color: .orange,
                    emojis: ["🐭", "🐮", "🐯", "🐰", "🐵", "🐔", "🐶", "🐷", "🐲", "🐍", "🐴", "🐑"]),
              Theme(name: "Fruits",
                    color: .green,
                    emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"]),
              Theme(name: "Snacks",
                    color: .yellow,
                    emojis: ["🥮", "🍢", "🍡", "🍧", "🍨", "🍦", "🥧", "🧁", "🍰", "🍮", "🍭", "🍬", "🍫", "🍿", "🍩", "🍪"]),
              Theme(name: "Drinks",
                    color: .pink,
                    emojis: ["🥛", "🍼", "🫖", "☕️", "🍵", "🧃", "🥤", "🧋", "🍶", "🍺", "🍻", "🥂", "🍷", "🥃", "🍸", "🍹", "🧉", "🍾"]),
              Theme(name: "Sports",
                    color: .blue,
                    emojis: ["⚽️", "🏀", "🏈", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🏹", "🥊", "🤿"])]
