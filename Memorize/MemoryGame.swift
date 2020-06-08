//
//  MemoryGame.swift
//  Memorize
//
//  Created by Vincent on 6/3/20.
//  Copyright © 2020 CS193. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var theIndexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{ cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = newValue == index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: ((Int) -> CardContent)) {
        cards = [Card]()
        for i in 0..<numberOfPairsOfCards {
            let cardContent = cardContentFactory(i)
            cards.append(Card(content: cardContent, id: i * 2))
            cards.append(Card(content: cardContent, id: i * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        print("card chose: \(card)")
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
        guard !cards[index].isFaceUp && !cards[index].isMatched else { return }
        
        if let potentialMatchIndex = theIndexOfTheOneAndOnlyFaceUpCard {
            if cards[potentialMatchIndex].content == cards[index].content {
                cards[potentialMatchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp.toggle()
        } else {
            theIndexOfTheOneAndOnlyFaceUpCard = index
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id: Int
        
        //MARK: Bonus Time
        
        // This could give matching bonus points
        // if the user mathes the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let date = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(date)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportulity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - pastFaceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
