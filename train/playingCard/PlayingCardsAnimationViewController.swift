//
//  PlayingCardsAnimationViewController.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 4/6/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import UIKit

class PlayingCardsAnimationViewController: UIViewController {
    
    private var deck = PlayingCardDeck()
    
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
    private lazy var cardBehavior = CardBehavior(in: animator)
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    override func viewDidLoad() {
        var cards = [PlayingCard]()
        for _ in 1...(cardViews.count/2) {
            if let card = deck.draw() {
                cards += [card, card]
            }
        }
        for cardView in cardViews {
            let card = cards.remove(at: cards.count.arc4random)
            cardView.isFaceUp = false
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            cardBehavior.add(cardView)
        }
    }
    
    private var faceUpCards: [PlayingCardView] {
        return cardViews.filter { $0.isFaceUp && !$0.isHidden &&
            $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) &&
            $0.alpha == 1
        }
    }
    
    private var isFacedUpCardsMatched: Bool {
        return faceUpCards.count == 2 &&
            faceUpCards[0].rank == faceUpCards[1].rank &&
            faceUpCards[0].suit == faceUpCards[1].suit
    }
    
    private var lastChoosenCard: PlayingCardView?
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let cardView = recognizer.view as? PlayingCardView, faceUpCards.count < 2 {
                lastChoosenCard = cardView
                cardBehavior.remove(cardView)
                UIView.transition(
                    with: cardView,
                    duration: 0.6,
                    options: [.transitionFlipFromLeft],
                    animations: {
                        cardView.isFaceUp = !cardView.isFaceUp
                    },
                    completion: { finished in
                        let cardsToAnimate = self.faceUpCards
                        if self.isFacedUpCardsMatched {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.6,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardsToAnimate.forEach { cardView in
                                        cardView.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                    }
                                },
                                completion: { position in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.75,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            cardsToAnimate.forEach { cardView in
                                                cardView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                cardView.alpha = 0
                                            }
                                        },
                                        completion: { position in
                                            cardsToAnimate.forEach { cardView in
                                                cardView.isHidden = true
                                                cardView.alpha = 1
                                                cardView.transform = .identity
                                            }
                                        }
                                    )
                                }
                            )
                        }
                        else if cardsToAnimate.count == 2 {
                            if cardView == self.lastChoosenCard {
                                cardsToAnimate.forEach { cardView in
                                    UIView.transition(
                                        with: cardView,
                                        duration: 0.5,
                                        options: [.transitionFlipFromLeft],
                                        animations: { cardView.isFaceUp = false },
                                        completion: { finished in
                                            self.cardBehavior.add(cardView)
                                    }
                                    )
                                }
                            }
                        }
                        else {
                            if !cardView.isFaceUp {
                                self.cardBehavior.add(cardView)
                            }
                        }
                    }
                )
            }
        default: break
        }
    }

}


extension CGFloat {
    var arc4random: CGFloat {
        if self == 0 {
            return 0
        }
        else if self > 0 {
            return CGFloat(arc4random_uniform(UInt32(self)))
        }
        else {
            return -CGFloat(arc4random_uniform(UInt32(abs(self))))
        }
    }
}














