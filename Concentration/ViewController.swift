//
//  ViewController.swift
//  Concentration
//
//  Created by Paul Matlashewski on 8/11/18.
//  Copyright © 2018 Paul Matlashewski. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfCardPairs: numberOfCardPairs)
    private var themes = themeSet()
    private lazy var currentTheme = themes.initialTheme()
    
    var numberOfCardPairs: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBOutlet private var currentView: UIView!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        currentTheme = themes.selectRandomTheme()
        updateThemeView()
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        // Update score
        scoreLabel.text = "Score: \(game.score)"
        
        // Update cards
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for:UIControlState.normal)
                button.backgroundColor = currentTheme.cardColor
            } else {
                button.setTitle("", for:UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0): currentTheme.cardColor
            }
        }
    }
    
    private func updateThemeView(){
        currentView.backgroundColor = currentTheme.backgroundColor
        scoreLabel.textColor = currentTheme.cardColor
        newGameButton.setTitleColor(currentTheme.cardColor, for: UIControlState.normal)
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, currentTheme.emojiSet.count > 0 {
            emoji[card.identifier] = currentTheme.emojiSet.remove(at: currentTheme.emojiSet.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

// Random number extension for Int
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

















