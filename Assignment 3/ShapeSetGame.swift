//
//  ShapeSetGame.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import SwiftUI

class ShapeSetGame: ObservableObject {
    typealias Card = SetGame.Card
    @Published private var setGame: SetGame
    private(set) var numberOfCards: Int
    
    init() {
        setGame = SetGame()
        numberOfCards = 12
    }
    
    struct getCardContent: View {
        var card: Card
        
        var body: some View {
            let color = getColor(card.color)
            let quantity = getNumberOfShapes(card.numberOfShapes)
            let shading = getShading(card.shading)
            VStack {
                Spacer()
                ForEach(0..<quantity, id: \.self){ index in
                    switch(card.shape){
                    case .firstPossibility:
                        ZStack{
                            Diamond().stroke(lineWidth: 2)
                            Diamond().opacity(shading)
                        }
                    case .secondPossibility:
                        ZStack{
                            Oval().stroke(lineWidth: 2)
                            Oval().opacity(shading)
                        }
                    case .thirdPossibility:
                        ZStack{
                            Squiggle()
                                .stroke(lineWidth: 2 * 1/0.65)
                                .scaleEffect(x: 0.65, y: 0.65, anchor:.center)
                            Squiggle()
                                .opacity(shading)
                                .scaleEffect(x: 0.65, y: 0.65, anchor:.center)
                        }
                    }
                    Spacer()
                }
                .foregroundColor(color)
    
            }
        }

        private func getColor(_ color: Feature) -> Color {
            switch(color){
            case .firstPossibility:
                return Color(.green)
            case .secondPossibility:
                return Color(.purple)
            case .thirdPossibility:
                return Color(.red)
            }
        }
        
        private func getNumberOfShapes(_ count: Feature) -> Int {
            switch(count){
            case .firstPossibility:
                return 1
            case .secondPossibility:
                return 2
            case .thirdPossibility:
                return 3
            }
        }
        
        private func getShading(_ opacity: Feature) -> Double {
            switch(opacity){
            case .firstPossibility:
                return 1
            case .secondPossibility:
                return 0.2
            case .thirdPossibility:
                return 0
            }
        }
        
    }
    
    func addCards() {
        setGame.addCards()
    }
    
    var canAddNewCards: Bool {
        setGame.canAddNewCards
    }
    
    func newGame() {
        setGame.newGame()
    }
    var cards: [Card] {
        setGame.cards
    }
    
    func choose(card: Card) {
        setGame.choose(card: card)
    }
}



