//
//  Concentration.swift
//  Concentration
//
//  Created by Paul Matlashewski on 8/11/18.
//  Copyright © 2018 Paul Matlashewski. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    private(set) var score = 0
    private var visitedCardIndices = [Int]()
    
    var indexOfOneAndOnlyFaceFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private func shuffleCards() {
        var randomCards = [Card]()
        for _ in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            randomCards.append(cards.remove(at: randomIndex))
        }
        cards = randomCards
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else if visitedCardIndices.contains(index) && visitedCardIndices.contains(matchIndex) {
                    // Both cards selected have previously been visited so a double
                    // penaly is incurred
                    score -= 2
                } else if visitedCardIndices.contains(index) || visitedCardIndices.contains(matchIndex) {
                    // A single card selected has previously been selected
                    score -= 1
                } else {
                    // This is a mismatch and the first time this card has been selected.
                    // Remember the card to penalize the player in case it is selected again.
                    if !visitedCardIndices.contains(index) {
                        visitedCardIndices.append(index)
                    }
                    if !visitedCardIndices.contains(matchIndex) {
                        visitedCardIndices.append(matchIndex)
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceFaceUpCard = index
            }
        }
    }
    
    // Start a new game by turning all cards face down, removing matches, and shuffling
    func newGame() {
        score = 0
        visitedCardIndices = [Int]()
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        shuffleCards()
    }
    
    init(numberOfCardPairs: Int) {
        assert(numberOfCardPairs > 0, "Concentration.init(\(numberOfCardPairs)): you must have at least one pair of cards")
        // Create a set of cards
        for _ in 0..<numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        shuffleCards()
    }
}
