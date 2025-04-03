//
//  ThemeCards.swift
//  Memorize
//
//  Created by José Isaac on 26/03/25.
//

import Foundation

struct MatchStyle {
    private var themes: [Theme] = [
        HalloweenThemeCards(),
        VehiclesThemeCards(),
        ExpressionsThemeCards(),
        AnimalsThemeCards(),
    ]
    
    private(set) var selectedTheme: Theme
    
    init() {
        selectedTheme = themes[0]
    }
    
    mutating func getNewTheme() {
        themes.shuffle()
        selectedTheme = themes[0]
    }
    
    protocol Theme {
        var name: String { get }
        var emojis: [String] { get }
        var numberOfPairs: Int { get }
        var color: String { get }
    }
}
