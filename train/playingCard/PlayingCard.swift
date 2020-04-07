//
//  PlayingCard.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 4/2/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    var description: String { return "\(rank)\(suit)" }
    
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        
        var description: String { return self.rawValue }
        
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }
    
    enum Rank: CustomStringConvertible {
        
        var description: String {
            switch self {
                case .ace: return "A"
                case .numeric(let pips): return String(pips)
                case .face(let kind): return kind
            }
        }
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric(let pipsCount): return pipsCount
                case .face(let type) where type == "J": return 11
                case .face(let type) where type == "Q": return 12
                case .face(let type) where type == "K": return 13
                default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks: [Rank] = [.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
}
