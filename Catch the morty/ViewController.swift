//
//  ViewController.swift
//  Catch the morty
//
//  Created by Subhamoy Paul on 10/18/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var morty1: UIImageView!
    
    @IBOutlet weak var morty2: UIImageView!
    
    @IBOutlet weak var morty3: UIImageView!
    
    @IBOutlet weak var morty4: UIImageView!
    
    @IBOutlet weak var morty5: UIImageView!
    
    @IBOutlet weak var morty6: UIImageView!
    
    @IBOutlet weak var morty7: UIImageView!
    
    @IBOutlet weak var morty8: UIImageView!

   
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    
    
    
    var score = 0
    
    var counter = 0
    
    var timer = Timer()
    
    var hideTimer = Timer()
    
    var mortyArray = [UIImageView]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        
        
        
        
        
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        
        morty1.addGestureRecognizer(recognizer1)
        morty2.addGestureRecognizer(recognizer2)
        morty3.addGestureRecognizer(recognizer3)
        morty4.addGestureRecognizer(recognizer4)
        morty5.addGestureRecognizer(recognizer5)
        morty6.addGestureRecognizer(recognizer6)
        morty7.addGestureRecognizer(recognizer7)
        morty8.addGestureRecognizer(recognizer8)
        
        morty1.isUserInteractionEnabled = true
        morty2.isUserInteractionEnabled = true
        morty3.isUserInteractionEnabled = true
        morty4.isUserInteractionEnabled = true
        morty5.isUserInteractionEnabled = true
        morty6.isUserInteractionEnabled = true
        morty7.isUserInteractionEnabled = true
        morty8.isUserInteractionEnabled = true
        
        counter = 30
        timerLabel.text = "\(counter)"
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMorty), userInfo: nil, repeats: true)
        
        
        mortyArray.append(morty1)
        mortyArray.append(morty2)
        mortyArray.append(morty3)
        mortyArray.append(morty4)
        mortyArray.append(morty5)
        mortyArray.append(morty6)
        mortyArray.append(morty7)
        mortyArray.append(morty8)
        
        hideMorty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func IncreaseScore() {
        
        score += 1
        
        scoreLabel.text = "Score: \(score)"
        
    }

    func countDown() {
        counter = counter - 1
        timerLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highScoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
            }
            
            let alert = UIAlertController(title: "Time", message: "Your Time Is Up", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.score = 0
                self.counter = 30
                self.scoreLabel.text = "Score: \(self.score)"
                self.timerLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMorty), userInfo: nil, repeats: true)
                })
            
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func hideMorty(){
        
        for morty in mortyArray {
            morty.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(mortyArray.count - 1)))
        mortyArray[randomNumber].isHidden = false
    }
    
    
    
    
}

