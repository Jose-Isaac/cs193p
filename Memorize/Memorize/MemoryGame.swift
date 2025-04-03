//
//  MomoryGame.swift
//  Memorize
//
//  Created by José Isaac on 19/03/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(
        numberOfPairOfCards: Int,
        createCardContent: (Int) -> CardContent
    ) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            
            if let potencialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                if cards[potencialMatchIndex].content == cards[chosenIndex].content {
                    cards[potencialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
                
                computeScore(
                    cardOne: cards[potencialMatchIndex],
                    cardTwo: cards[chosenIndex]
                )
                
                cards[chosenIndex].isFacaUpCount += 1
                cards[potencialMatchIndex].isFacaUpCount += 1
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    if (!cards[index].isMatched) {
                        cards[index].isFaceUp = false
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            
            print("\nscore: \(score)")
        }
    }
    
    private mutating func computeScore(cardOne: Card, cardTwo: Card) {
        if (cardOne.isMatched && cardTwo.isMatched) {
            score += 2
        } else if (cardOne.isFacaUpCount >= 1) || (cardTwo.isFacaUpCount >= 1) {
            score -= 1
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isFacaUpCount: Int = 0
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
