//
//  EmojiMemoryGame.swift
//  Memorize_2021
//
//  Created by Kamil on 04.07.2021.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    @Published private var model : MemoryGame<String> = createMemoryGame()
    
    enum Themes : CaseIterable {
        case cars
        case sport
        case halloween
        case clothes
        case animals
        case food
    }

    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(chooseTheme: chooseRandomTheme)

    }

    static func chooseRandomTheme() -> MemoryGame<String>.Theme{
        let randomChoice = Themes.allCases.randomElement()!
        let randomNumberOfPairs = Int.random(in: 1...14)
        print(randomChoice)
        switch randomChoice {
        case .cars:
            let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"]
            return MemoryGame<String>.Theme(name: "Cars", content: emojis, numberOfPairsOfCards: randomNumberOfPairs, color: "red")
        case .sport:
            let emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏆", "🥇", "🥈", "🥉"]
            return MemoryGame<String>.Theme(name: "Sport", content: emojis, numberOfPairsOfCards: randomNumberOfPairs, color: "blue")
        case .halloween:
            let emojis = ["🎃", "💀", "👻", "🦴", "👀", "🩸", "🦸", "🧙‍♀️", "🧛‍♂️", "🧟‍♂️"]
            return MemoryGame<String>.Theme(name: "Halloween", content: emojis, numberOfPairsOfCards: randomNumberOfPairs, color: "black")
        case .clothes:
            let emojis = ["🕶", "👔", "👕", "👖", "🧤", "👗", "👚", "👙", "👜", "🎒", "🩳", "🩱"]
            return MemoryGame<String>.Theme(name: "Clothes", content: emojis, numberOfPairsOfCards: randomNumberOfPairs, color: "yellow")
        case .animals:
            let emojis = ["🐸", "🦊", "🦁", "🐵", "🐧", "🐭", "🐼", "🐔", "🦆", "🦉", "🐺", "🐌"]
            return MemoryGame<String>.Theme(name: "Animals", content: emojis, numberOfPairsOfCards: randomNumberOfPairs, color: "green")
        case .food:
            let emojis = ["🥦", "🍅", "🍆", "🌶", "🍒", "🧇", "🍏", "🍌", "🍉", "🍔", "🍰", "🥂", "🍩"]
            return MemoryGame<String>.Theme(name: "Food", content: emojis, numberOfPairsOfCards: randomNumberOfPairs, color: "white")
        }
        
    }

    var cards : Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card : MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame(){
        model.newGame(chooseTheme : EmojiMemoryGame.chooseRandomTheme)
    }
    
    var getThemeName : String {
        model.currentTheme.name
    }
    
    var score : Int {
        return model.score
    }
    
    var color : Color {
        switch model.currentTheme.color{
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "black":
            return Color.black
        case "green":
            return Color.green
        case "yellow":
            return Color.yellow
        default:
            return Color.red
        }
    }
}

