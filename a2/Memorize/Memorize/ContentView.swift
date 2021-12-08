//
//  ContentView.swift
//  Memorize
//
//  Created by Caci Jiang on 3/29/21.
//

import SwiftUI

struct ContentView: View {
    // pre-defined card contents for different themes
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.theme.name).font(.largeTitle)
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                        }
                    }
                }
            }
            .foregroundColor(viewModel.theme.color)
            Spacer()
            HStack{
                Text("Your Score: \(viewModel.score)")
                    .font(.title2)
                    .foregroundColor(Color.blue)
                Spacer()
                newGameButton
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var newGameButton: some View {
        Button {
            viewModel.newGame()
        } label: {
            Text("New Game")
                .font(.title2)
                .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 3)
            )
        }
    }
}

struct CardView: View {
    let card:MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
