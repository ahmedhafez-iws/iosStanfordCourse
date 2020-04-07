//
//  PlayingCardDeck.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 4/2/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        }
        else {
            return nil
        }
    }
}
