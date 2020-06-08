//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Vincent on 6/3/20.
//  Copyright © 2020 CS193. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😂", "👻", "🤪"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { index in
            emojis[index]
        }
    }
    
    //MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
