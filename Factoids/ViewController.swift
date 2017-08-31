//
//  ViewController.swift
//  Factoids
//
//  Created by Thomas Le on 8/30/17.
//  Copyright © 2017 Thomas Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /* 1. @IBOutlet, interface builder outlet lets compiler know that this is
            an interface code piece. Syncs the corresponding button up with our
            code.
     
        2. weak: memory management. signals that it is a weak relationship in mem
     
        3. !: optional. lets the compiler know that this value might be nil because
            it is loaded as needed and may not always be there
 
     */
    @IBOutlet weak var factoidLabel: UILabel!
    
    let factProvider = FactProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad() // any code they write gets run before our code
        
        factoidLabel.text = factProvider.randomFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Every time button is pressed, this method is called
    @IBAction func showFact() {
        
        factoidLabel.text = factProvider.randomFact()
    }

}

