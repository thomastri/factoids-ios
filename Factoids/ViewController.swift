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
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {

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
        
        factoidButton.layer.cornerRadius = 10
        factoidFakeButton.layer.cornerRadius = 10
        
        factoidLabel.text = factProvider.randomFact()
        highScore.text = "High Score: \(factProvider.updateAndGetHighScore())"
        
        // loads banner ad
        adBannerView.load(GADRequest())
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
    @IBAction func realFactPress() {
        
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
    
    /*
     ----------- START BANNER ADS -----------
     */
    
    // View to be used for banner ad
    // lazy allows for initialization later rather than now
    lazy var adBannerView: GADBannerView = {
        
        // smartBanners adjust width / size accordingly
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        
        // Test banner:
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        
        // Real $$$ banner:
        // adBannerView.adUnitID = "ca-app-pub-9581090984969636/5782838902"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        // Moves the banner down to not cover the status bar at the top
        adBannerView.frame = CGRect(x: 0.0,
                                  y: UIApplication.shared.statusBarFrame.size.height,
                                  width: adBannerView.frame.width,
                                  height: adBannerView.frame.height)
        
        return adBannerView
    }()
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        view.addSubview(bannerView)
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
    
    /*
     ----------- END BANNER ADS -----------
     */
    
    // TODO: refactor methods from FactProvider over to ViewController in order to
    // animate and color scores on every wrong answer and high score updates
}

