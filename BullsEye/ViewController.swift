//
//  ViewController.swift
//  BullsEye
//
//  Created by ilias tzallas on 30/10/2017.
//  Copyright © 2017 ilias tzallas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue: Int = 0
    @IBOutlet weak var label: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var round = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        StartOver()
        
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .normal)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightImage, for: .normal)
        
    }
    
    
    
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()
    }
    
    func updateLabel(){
        label.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderMove(_ slider: UISlider) {
        //print("the value of the slider now is \(slider.value)")
        currentValue = lroundf(slider.value)
    }

    @IBAction func ShowAlert() {
        
        let difference: Int = abs(currentValue - targetValue)
        var points = 100 - difference
        score += points
        
        
        let title : String
        if difference == 0 {
            title = "Perfect"
            points += 100
        }else if difference < 2 {
            title = "Only 1 away!!"
            points += 50
        }else if difference < 5 {
            title = "You almost had it!"
        }else if difference < 10{
            title = "Pretty good!"
        }else{
            title = "Not even close.."
        }
        
        
        let message = "you score \(points) points!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func StartOver(){
        score = 0
        round = 0
        startNewRound()
    }
    
}

