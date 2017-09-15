//
//  ViewController.swift
//  Factoids
//
//  Created by Thomas Le on 8/30/17.
//  Copyright © 2017 Thomas Le. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftySound

class ViewController: UIViewController {

    /* 1. @IBOutlet, interface builder outlet lets compiler know that this is
            an interface code piece. Syncs the corresponding button up with our
            code.
     
        2. weak: memory management. signals that it is a weak relationship in mem
     
        3. !: optional. lets the compiler know that this value might be nil because
            it is loaded as needed and may not always be there
 
     */
    @IBOutlet weak var factoidLabel: UILabel!
    @IBOutlet weak var factoidButton: UIButton!
    @IBOutlet weak var factoidNumber: UILabel!
    @IBOutlet weak var factoidScore: UILabel!
    @IBOutlet weak var factoidFakeButton: UIButton!
    @IBOutlet weak var highScore: UILabel!
    
    var factProvider = FactProvider()
    let colorProvider = BackgroundColorProvider()
    var factOrFake = 2
    
    override func viewDidLoad() {
        super.viewDidLoad() // any code they write gets run before our code
        let _ = Sound.enabled
        
        factoidLabel.text = factProvider.randomFact()
        highScore.text = "High Score: \(factProvider.updateAndGetHighScore())"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeBGColor() {
        let randomColor = colorProvider.randomColors()
        view.backgroundColor = randomColor
        factoidButton.tintColor = randomColor
    }
    
    func newFact() {
        factOrFake = factProvider.getFactOrFake() // 0 or 1 for random fact
        factoidLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true)
        factoidLabel.text = factProvider.randomFact() // re-rolls factOrFake, presents a fact
        
        factoidNumber.text = "Factoid #\(factProvider.getFactNum()):"
        factoidNumber.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.5)
    }
    
    func updateScores() {
        factoidScore.text = "Score: \(factProvider.getScore())"
        highScore.text = "High Score: \(factProvider.updateAndGetHighScore())"
        
        factoidScore.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.75)
        highScore.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.85)
    }

    // Every time FactButton is pressed, this method is called
    @IBAction func showFact() {
        
        changeBGColor()
        newFact()
        
        if (factOrFake == 0) {
            factProvider.increaseScore()
        } else {
            factProvider.resetScore()
        }

        updateScores()
        
    }
    
    @IBAction func fakeFactPress() {
        
        changeBGColor()
        newFact()
        
        if (factOrFake == 1) {
            factProvider.increaseScore()
        } else {
            factProvider.resetScore()
        }
        
        updateScores()
    }
    
    // TODO: refactor methods from FactProvider over to ViewController in order to
    // animate and color scores on every wrong answer and high score updates
}

