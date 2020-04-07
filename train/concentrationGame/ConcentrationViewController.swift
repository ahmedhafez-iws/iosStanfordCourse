//
//  ViewController.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 3/27/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // computed property with get only
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount: Int = 0 {
        didSet {
            updateFlipLabel()
        }
    }
    
    private func updateFlipLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        
        let font = UIFont(name: "Helvetica", size: 40.0)
        let metrics = UIFontMetrics(forTextStyle: .body)
        let usedFont = metrics.scaledFont(for: font!)
        flipCountLabel.font = usedFont
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func clickCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            if !game.cards[cardNumber].isMatched {
                flipCount += 1
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    override func viewDidLoad() {
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let card = game.cards[index]
                let button = cardButtons[index]
                
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
                else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                    button.isEnabled = card.isMatched ? false : true
                }
            }
        }
    }

    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🎃🔍👻✂️📖📎🛎🔑🎁💣⏰"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at:randomStringIndex))
        }
        // return this operation or ? if the operation is nil
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self == 0 {
            return 0
        }
        else if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
    }
}


















