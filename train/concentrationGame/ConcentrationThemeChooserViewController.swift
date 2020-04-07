//
//  ConcentrationThemeChooserViewController.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 4/6/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = [
        "Sports": "🏐🏈🏉🏀🎱🚴‍♂️🏊‍♀️🏑🥊🤾‍♀️🏎🏸🤺🥋⛸⚽️⚾️",
        "Faces": "😀☺️😇😍😜🤓🤪😎🤩🙁😤😡😱😰🤢😷🤮🤧",
        "Animals": "🦓🦒🦔🦕🦖🐅😺🐌🐐🐑🙉🐛🐣🐼🐻🐯🐨🐪"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    @IBAction func chooseSportsTheme(_ sender: UIButton) {
        if let splitVc = conscentrationViewControllerOfSplitViewController {
            if let themeName = sender.currentTitle, let theme = themes[themeName] {
                splitVc.theme = theme
            }
        }
        else if let lastVC = lastSeguedToVC {
            if let themeName = sender.currentTitle, let theme = themes[themeName] {
                lastVC.theme = theme
            }
            navigationController?.pushViewController(lastVC, animated: true)
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var conscentrationViewControllerOfSplitViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToVC: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let concentrationVC = segue.destination as? ConcentrationViewController {
                    concentrationVC.theme = theme
                    lastSeguedToVC = concentrationVC
                }
            }
        }
    }

}
