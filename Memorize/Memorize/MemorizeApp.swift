//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jose Isaac Barreiro Campos on 04/03/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMomoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(
                gameViewModel: game
            )
        }
    }
}
