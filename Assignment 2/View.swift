//
//  ContentView.swift
//  Memorize_2021
//
//  Created by Kamil on 02.07.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        VStack{
            Text(viewModel.getThemeName)
            Text("Score : \(viewModel.score)")
            ScrollView {
                LazyVGrid(columns : [GridItem(.adaptive(minimum : 65))]) {
                    ForEach(viewModel.cards) {card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            Button(){
                viewModel.newGame()
            } label: {
                    Text("New Game")
                        .foregroundColor(.blue)
            }
        }
        .foregroundColor(viewModel.color)
        .font(.largeTitle)
        .padding(.horizontal)
    }
}

struct CardView : View {
    let card : MemoryGame<String>.Card
    
    var body : some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2)
                Text(card.content).font(.largeTitle)
            }
            else if card.isMatched{
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
