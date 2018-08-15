//
//  Theme.swift
//  Concentration
//
//  Created by Paul Matlashewski on 8/13/18.
//  Copyright © 2018 Paul Matlashewski. All rights reserved.
//

import UIKit

// Concentration theme. Defaults to halloween
struct Theme {
    var backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var cardColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    var emojiSet = ["🎃", "👻", "🍬", "🍭", "🍫", "😈", "👹", "🙀"]
    
    init(backgroundColor: UIColor, cardColor: UIColor, emojiSet: [String]) {
        self.backgroundColor = backgroundColor
        self.cardColor = cardColor
        self.emojiSet = emojiSet
    }
}

class themeSet {
    var themes = [String: Theme]()
    
    func selectRandomTheme() -> Theme {
        let numberOfThemes = themes.count
        let randomIndex = numberOfThemes.arc4random
        return Array(themes.values)[randomIndex]
    }
    
    func addTheme(themeName: String, backgroundColor: UIColor, cardColor: UIColor, emojiSet: [String]) {
        themes[themeName] = Theme(backgroundColor: backgroundColor, cardColor: cardColor, emojiSet: emojiSet)
    }
    
    // Use halloween as the starting theme to match the intial storyboard
    func initialTheme() -> Theme {
        return themes["halloween"]!
    }

    init() {
        let halloween = Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                              cardColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1),
                              emojiSet: ["🎃", "👻", "🍬", "🍭", "🍫", "😈", "👹", "🙀"])
        let christmas = Theme(backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
                              cardColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                              emojiSet: ["🎅🏻", "🎁", "🍪", "🦌", "🎄", "🤶🏻", "❄️", "⛄️"])
        let easter = Theme(backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                           cardColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                           emojiSet: ["🐰", "🥚", "🍫", "🌸", "🌼", "🍭", "☀️", "🌺"])
        
        themes["halloween"] = halloween
        themes["christmas"] = christmas
        themes["easter"] = easter
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
