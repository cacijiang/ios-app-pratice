//
//  ContentView.swift
//  Memorize
//
//  Created by Caci Jiang on 3/29/21.
//

import SwiftUI

struct ContentView: View {
    // pre-defined card contents for different themes
    var vehicles = ["🚲", "🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚍", "🚝", "🛰"]
    var animals = ["🐭", "🐮", "🐯", "🐰", "🐵", "🐔", "🐶", "🐷", "🐲", "🐍", "🐴", "🐑"]
    var fruits = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"]
    
    @State var emojis = ["🚲", "🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚍", "🚝", "🛰"]
    
    @State var emojiCount = 24
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehicleTheme.padding(.horizontal)
                Spacer()
                animalTheme.padding(.horizontal)
                Spacer()
                fruitTheme.padding(.horizontal)
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    // buttons to switch theme
    var vehicleTheme: some View {
        Button {
            emojis = vehicles.shuffled()
            emojiCount = emojis.count
        } label: {
            VStack {
                Image(systemName: "car.fill")
                    // make sure the image captions are in the same level
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0)
                Text("Vehicles").font(.caption)
            }
        }
    }
    
    var animalTheme: some View {
        Button {
            emojis = animals.shuffled()
            emojiCount = emojis.count
        } label: {
            VStack {
                Image(systemName: "hare.fill")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0)
                Text("Animals").font(.caption)
            }
        }
    }
    
    var fruitTheme: some View {
        Button {
            emojis = fruits.shuffled()
            emojiCount = emojis.count
        } label: {
            VStack {
                Image(systemName: "applelogo")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0)
                Text("Fruits").font(.caption)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
