//
//  SetGame.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import Foundation

struct SetGame {
    
    private var deck: [Card]
    private(set) var cards: [Card]
    
    private var numberOfChoosenCards: Int {
        get{ cards.indices.filter({cards[$0].isChoosen}).count}
    }

    private var isMatchUpdated: Bool
    private(set) var canAddNewCards: Bool
    
    struct Card: Identifiable, Hashable {
        let id: Int
        let numberOfShapes: Feature
        let shape: Feature
        let shading: Feature
        let color: Feature
        var isChoosen = false
        var isMatched: Bool?
    }
    
    init() {
        isMatchUpdated = true
        canAddNewCards = true
        var id = 0
        cards = []
        deck = []
        for numberOfShapes in Feature.allCases {
            for shape in Feature.allCases {
                for shading in Feature.allCases {
                    for color in Feature.allCases {
                        let newCard = Card(id: id, numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color)
                        deck.append(newCard)
                        id += 1
                    }
                }
            }
        }
        deck.shuffle()
        for _ in 0..<12 {
            cards.append(deck[0])
            deck.removeFirst()
        }
    }
    
    mutating func newGame() {
        self = SetGame.init()
    }
    
    mutating func choose(card: Card) {
        if let cardIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !isMatchUpdated {
                if let _ = cards[cardIndex].isMatched{
                    return
                }
                else {
                    removeSet()
                }
            }
            cards[cardIndex].isChoosen.toggle()
        }
        if numberOfChoosenCards == 3 {
            let result = findSet()
            result ? print("this is set") : print("this is not a set")
            isMatchUpdated = false
        }

    }
    
    mutating private func removeSet() {
        if deck.count > 2 {
            let matchedIndeces = cards.indices.filter({cards[$0].isMatched == true})
            for index in matchedIndeces {
                if let newElement = deck.first {
                    cards[index] = newElement
                    deck.removeFirst()
                }
            }
        }
        else {
            cards = cards.filter({$0.isMatched != true})
        }
        cards.indices.forEach { cards[$0].isMatched = nil }
        isMatchUpdated = true
    }
    
    mutating func addCards() {
        if !isMatchUpdated {
            removeSet()
        }
        for _ in 0..<3 {
            if let newElement = deck.first {
                cards.append(newElement)
                deck.removeFirst()
            }
            else {
                canAddNewCards = false
            }
        }
    }
    
    mutating private func findSet() -> Bool {
        var choosenIndeces: [Int] = []
        
        cards.indices.forEach {
            if cards[$0].isChoosen {
                choosenIndeces.append($0)
                cards[$0].isChoosen = false
            }
        }
        
        let firstIndex = choosenIndeces[0]
        let secondIndex = choosenIndeces[1]
        let thirdIndex = choosenIndeces[2]
        
        let firstConditionSatisfied = areSatisfying(cards[firstIndex].numberOfShapes, cards[secondIndex].numberOfShapes, cards[thirdIndex].numberOfShapes)
        let secondConditionSatisfied = areSatisfying(cards[firstIndex].color, cards[secondIndex].color, cards[thirdIndex].color)
        let thirdConditionSatisfied = areSatisfying(cards[firstIndex].shape, cards[secondIndex].shape, cards[thirdIndex].shape)
        let fourthConditionSatisfied = areSatisfying(cards[firstIndex].shading, cards[secondIndex].shading, cards[thirdIndex].shading)
        
        if firstConditionSatisfied && secondConditionSatisfied && thirdConditionSatisfied && fourthConditionSatisfied {
            
            for index in choosenIndeces {
                cards[index].isMatched = true
            }
            return true
        }
        
        for index in choosenIndeces {
            cards[index].isMatched = false
        }
        return false
    }
    
}

private func areSatisfying<T>(_ a: T, _ b: T, _ c: T) -> Bool where T: Equatable {
    if a == b && b == c {
        return true
    }
    else if a != b && b != c && a != c {
        return true
    }
    return false
}

enum Feature: CaseIterable {
    case firstPossibility
    case secondPossibility
    case thirdPossibility
}
