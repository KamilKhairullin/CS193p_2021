//
//  MemoryGame.swift
//  Memorize_2021
//
//  Created by Kamil on 04.07.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    
    private(set) var cards : Array<Card>
    private var indexOfTheOnlyAndOnlyFaceUpCard : Int?
    private(set) var currentTheme : Theme
    private(set) var score : Int
    
    init(chooseTheme: () -> Theme){
        score = 0
        cards = Array<Card>()
        currentTheme = chooseTheme()
        fillUpCards()
    }
    
    mutating func newGame(chooseTheme: () -> Theme) {
        score = 0
        cards = Array<Card>()
        currentTheme = chooseTheme()
        fillUpCards()
    }
    
    mutating func fillUpCards(){
        let contentSize = currentTheme.content.count
        let randomKey = Int.random(in: 0..<contentSize)
        var numberOfPairsOfCards = currentTheme.numberOfPairsOfCards
        if numberOfPairsOfCards > contentSize{
            numberOfPairsOfCards = contentSize
        }
        for pairIndex in 0..<numberOfPairsOfCards {
            let potentialIndex = randomKey + pairIndex
            let index = potentialIndex < contentSize ? potentialIndex : potentialIndex - contentSize
            let content : CardContent = currentTheme.content[index]
            cards.append(Card(content: content, id : pairIndex * 2))
            cards.append(Card(content: content, id : pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card : Card) {
        if let safeChoosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[safeChoosenIndex].isFaceUp,
           !cards[safeChoosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOnlyAndOnlyFaceUpCard{
                if cards[safeChoosenIndex].content == cards[potentialMatchIndex].content{
                    cards[safeChoosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                else{
                    if cards[potentialMatchIndex].isSeen == true{
                        score -= 1
                    }
                    if cards[safeChoosenIndex].isSeen == true {
                        score -= 1
                    }
                }
                cards[potentialMatchIndex].isSeen = true
                cards[safeChoosenIndex].isSeen = true
                indexOfTheOnlyAndOnlyFaceUpCard = nil
            }
            else{
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOnlyAndOnlyFaceUpCard = safeChoosenIndex
            }
            cards[safeChoosenIndex].isFaceUp.toggle()
        }
        print(score)
    }
    
    struct Card : Identifiable {
        var isFaceUp : Bool = false
        var isMatched : Bool = false
        var isSeen : Bool = false
        var content : CardContent
        var id : Int
    }
    
    struct Theme {
        var name : String
        var content : Array<CardContent>
        var numberOfPairsOfCards : Int
        var color : String
    }
}
