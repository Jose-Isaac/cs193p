//
//  EmojiMomoryGame.swift
//  Memorize
//
//  Created by José Isaac on 19/03/25.
//

import SwiftUI

class EmojiMomoryGame: ObservableObject {
    private var themeModel: MatchStyle
    
    @Published
    private var model: MemoryGame<String>
    
    init() {
        let initialTheme = MatchStyle()
        
        self.themeModel = initialTheme
        self.model = MemoryGame<String>(numberOfPairOfCards: initialTheme.selectedTheme.numberOfPairs) {
            pairIndex in initialTheme.selectedTheme.emojis[pairIndex]
        }
    }
    
    var activeTheme: MatchStyle.Theme {
        themeModel.selectedTheme
    }
    
    var cardColor: Color {
        switch activeTheme.color {
            case "orange": .orange
            case "blue": .blue
            case "green": .green
            case "yellow": .yellow
            default: .red
        }
    }
    
    var score: Int {
        model.score
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func setNewTheme() {
        themeModel.getNewTheme()
        model = createMemoryGame()
    }
    
    private func createMemoryGame() -> MemoryGame<String> {
        let selectedTheme = themeModel.selectedTheme
        
        return MemoryGame<String>(numberOfPairOfCards: selectedTheme.numberOfPairs) {
            pairIndex in selectedTheme.emojis[pairIndex]
        }
    }
}
