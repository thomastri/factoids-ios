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
import SRCountdownTimer
import GameKit
import Spring

class ViewController: UIViewController, GADBannerViewDelegate, GKGameCenterControllerDelegate {

    /* 1. @IBOutlet, interface builder outlet lets compiler know that this is
            an interface code piece. Syncs the corresponding button up with our
            code.
     
        2. weak: memory management. signals that it is a weak relationship in mem
     
        3. !: optional. lets the compiler know that this value might be nil because
            it is loaded as needed and may not always be there
 
     */
    @IBOutlet weak var factoidLabel: SpringLabel!
    @IBOutlet weak var factoidButton: UIButton!
    @IBOutlet weak var factoidNumber: UILabel!
    @IBOutlet weak var factoidScore: UILabel!
    @IBOutlet weak var factoidFakeButton: UIButton!
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var timerAnimation: SRCountdownTimer!
    
    var factProvider = FactProvider()
    let colorProvider = BackgroundColorProvider()
    var factOrFake = 2
    
    override func viewDidLoad() {
        super.viewDidLoad() // any code they write gets run before our code
        let _ = Sound.enabled
        
        factoidButton.layer.cornerRadius = 10
        factoidFakeButton.layer.cornerRadius = 10
        
        
        // Call the GC authentication controller
        authenticateLocalPlayer()
        
        factoidLabel.text = factProvider.randomFact()
        highScore.text = "High Score: \(factProvider.updateAndGetHighScore())"
        
        factoidNumber.text = "Factoid #\(factProvider.getFactNum()):"
        
        changeColors()
        
        startTimer()
        
        // loads banner ad
        adBannerView.load(GADRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Timer
    var timer = Timer()
    var seconds = 10
    var isTimerRunning = false
    
    // Starts the timer
    func startTimer() {
        isTimerRunning = true
        changeTimerColor()
        timerAnimation.start(beginingValue: 10, interval: 1)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // This func is called every second
    func updateTimer() {
        if seconds == 0 {
            factProvider.resetScore()

            updateScores()
            newFact()
        } else {
            if (seconds <= 4) {
                timerAnimation.labelTextColor = .red
            }
            seconds -= 1
//            timerLabel.text = "\(seconds)"
        }
    }
    
    func newFact() {
        // If a timer is running, disable it so two or more timers can't run at the same time
        if isTimerRunning {
            timer.invalidate()
            seconds = 10
        }
        
        changeBGColor()
        
        factOrFake = factProvider.getFactOrFake() // 0 or 1 for random fact
        factoidLabel.text = factProvider.randomFact() // re-rolls factOrFake, presents a fact
        
        factoidNumber.text = "Factoid #\(factProvider.getFactNum()):"
        
        changeTextColor()
        
        // Starts the timer
        startTimer()
    }
    
    func updateScores() {
        factoidScore.text = "Score: \(factProvider.getScore())"
        highScore.text = "High Score: \(factProvider.updateAndGetHighScore())"
        
        changeScoreColor()
    }

    // Every time FactButton is pressed, this method is called
    @IBAction func realFactPress() {
        newFact()
        
        if (factOrFake == 0) {
            factProvider.increaseScore()
        } else {
            factProvider.resetScore()
            animateWrongFact()
        }

        updateScores()
        
    }
    
    @IBAction func fakeFactPress() {
        newFact()
        
        if (factOrFake == 1) {
            factProvider.increaseScore()
        } else {
            factProvider.resetScore()
            animateWrongFact()
        }
        
        updateScores()
    }
    
    fileprivate func animateWrongFact() {
        UIView.transition(with: factoidLabel, duration: 0.3, options: .transitionCrossDissolve, animations: { self.factoidLabel.textColor = UIColor.red }, completion: nil)
        
        factoidLabel.animation = "wobble"
        factoidLabel.animate()
    }
    
    
    fileprivate func changeTimerColor() {
        timerAnimation.lineColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.6)
        timerAnimation.labelTextColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.6)
    }
    
    fileprivate func changeBGColor() {
        let randomColor = colorProvider.randomColors()
        view.backgroundColor = randomColor
        factoidButton.tintColor = randomColor
    }
    
    fileprivate func changeTextColor() {
        factoidLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true)
        factoidNumber.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.5)
    }
    
    fileprivate func changeScoreColor() {
        factoidScore.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.75)
        highScore.textColor = UIColor(contrastingBlackOrWhiteColorOn: view.backgroundColor, isFlat: true, alpha: 0.85)
    }
    
    fileprivate func changeColors() {
        changeBGColor()
        changeTextColor()
        changeTimerColor()
        changeScoreColor()
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
//        adBannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        
        // Real $$$ banner:
        adBannerView.adUnitID = "ca-app-pub-9581090984969636/5782838902"
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
    
    // MARK: GameCenter leaderboards
    
    /* Variables */
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    var score = 0
    
    let LEADERBOARD_ID = "highScore"
    
    // MARK: - AUTHENTICATE LOCAL PLAYER
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print("There was an error!")
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
            }
        }
    }
    
    @IBAction func gcLeaderboards(_ sender: Any) {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
    }
    
    
    // Delegate to dismiss the GC controller
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: In-app review
    
    let runIncrementerSetting = "numberOfRuns"  // UserDefauls dictionary key where we store number of runs
    let minimumRunCount = 3
    
    var askForRatingsFlag: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "askForRatings")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "askForRatings")
        }
    }
    
    func incrementAppRuns() {                   // counter for number of runs for the app. You can call this from App Delegate
        
        let usD = UserDefaults()
        let runs = getRunCounts() + 1
        usD.setValuesForKeys([runIncrementerSetting: runs])
        usD.synchronize()
        
    }
    
    func getRunCounts () -> Int {               // Reads number of runs from UserDefaults and returns it.
        
        let usD = UserDefaults()
        let savedRuns = usD.value(forKey: runIncrementerSetting)
        
        var runs = 0
        if (savedRuns != nil) {
            
            runs = savedRuns as! Int
        }
        
        print("Run Counts are \(runs)")
        return runs
        
    }
    
    func showReview() {
        
        let runs = getRunCounts()
        print("Show Review")
        
        if (runs > minimumRunCount) {
            
            if #available(iOS 10.3, *) {
                print(askForRatingsFlag)
                if (askForRatingsFlag != true) {
                    print("Review Requested")
                    SKStoreReviewController.requestReview()
                    askForRatingsFlag = true
                }
                
            } else {
                // Fallback on earlier versions
            }
            
        } else {
            
            print("Runs are not enough to request review!")
            
        }
        
    }

    

}

