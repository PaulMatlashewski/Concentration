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
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceFaceUpCard = index
            }
        }
    }
    
    init(numberOfCardPairs: Int) {
        assert(numberOfCardPairs > 0, "Concentration.init(\(numberOfCardPairs)): you must have at least one pair of cards")
        // Create a set of cards
        for _ in 0..<numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        var randomCards = [Card]()
        for _ in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            randomCards.append(cards.remove(at: randomIndex))
        }
        cards = randomCards
    }
}
