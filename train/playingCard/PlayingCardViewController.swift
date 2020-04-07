//
//  playingCardViewController.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 4/2/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import UIKit

class PlayingCardViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: palyingCardView.isFaceUp = !palyingCardView.isFaceUp
        default: break
        }
    }
    
    @IBOutlet weak var palyingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            let pinch = UIPinchGestureRecognizer(target: palyingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(gestureRecognizer:)))
            palyingCardView.addGestureRecognizer(swipe)
            palyingCardView.addGestureRecognizer(pinch)
        }
    }
    
    @objc func nextCard() {
        if let card = deck.draw() {
            palyingCardView.rank = card.rank.order
            palyingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
