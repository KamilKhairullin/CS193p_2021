//
//  ContentView.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import SwiftUI

struct ShapeSetGameView: View {
    @ObservedObject var game: ShapeSetGame

    var body: some View {
        VStack{
            AspectVGrid(items: game.cards, aspectRatio: 2/3, minimalWidth: 100){ card in
                CardView(card: card)
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .padding(5)
                    .onTapGesture {
                        game.choose(card: card)
                    }
            }

            HStack {
                Button(
                    action:
                        {game.newGame()},
                    label: {
                        Text("New game")
                })
                Spacer()
                Button(
                    action:
                        {game.addCards()},
                    label: {
                        Text("Add more cards")
                })
                    .disabled(!game.canAddNewCards)
            }
            .font(.title)
            .padding(.all)
        }
    }
    
}

struct CardView: View {
    var card : ShapeSetGame.Card
    
    var body: some View {
        let cardContent = ShapeSetGame.getCardContent(card: card)
        let backgroundRectangle = RoundedRectangle(cornerRadius: 20)
                                      .foregroundColor(.white)
        ZStack{
            backgroundRectangle
            
            if card.isChoosen {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 2.0)
                    .foregroundColor(.blue)
            }
            else if let match = card.isMatched {
                let color: Color = match ? .green : .red
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.3)
                    .foregroundColor(color)
                }
            else {
                RoundedRectangle(cornerRadius: 20)
            }
            
            cardContent
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ShapeSetGame()
        ShapeSetGameView(game: game)
    }
}
