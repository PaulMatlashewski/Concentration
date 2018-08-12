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
    var cards = [Card]()
    var indexOfOneAndOnlyFaceFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceFaceUpCard = index
            }
        }
    }
    
    init(numberOfCardPairs: Int) {
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
