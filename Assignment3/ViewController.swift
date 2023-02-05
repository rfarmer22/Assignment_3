//
//  ViewController.swift
//  Assignment3
//
//  Created by Ross Farmer on 1/30/23.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var startAndStop: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var timer = Timer()
    var timeLeft : Int?
    var countdownTimer : Timer?
    var alarm: AVAudioPlayer!


    override func viewDidLoad() {
        super.viewDidLoad()
        //Timer for Clock
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
        
        //Set Background Image for AM vs. PM
        setBackground()
        
        //Style the Start/Stop button
        startAndStop.layer.cornerRadius = 12
        startAndStop.layer.borderWidth = 2
        startAndStop.layer.borderColor = UIColor.black.cgColor
        startAndStop.layer.backgroundColor = UIColor.gray.cgColor
        
        //Change timeLeftLabel to blank
        timeLeftLabel.text = ""
    }

    
    @objc func currentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        clock.text = formatter.string(from: Date())
        }

    @objc func setBackground(){
        let hour = Calendar.current.component(.hour, from: Date())
        print(hour)
        
        if(hour > 11){
            background.image = UIImage(named:"PM")
            background.contentMode = UIView.ContentMode.scaleAspectFill
        } else {
            background.image = UIImage(named:"AM")
            background.contentMode = UIView.ContentMode.scaleAspectFill
        }
    }
    
    @IBAction func startAndStopAction(_ sender: Any) {
        if (startAndStop.currentTitle == "Start Timer") {
            timeLeft = Int(datePicker.countDownDuration)
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(startCountDown), userInfo: nil, repeats: true)
        } else {
            alarm.pause()
            startAndStop.setTitle("Start Timer", for: .normal)
        }
    }
    
    @objc func startCountDown() {        
        if (timeLeft! >= 0) {
            timeLeftLabel.text = secondsToHoursMinutesSeconds(timeLeft!)
            timeLeft! -= 1
        } else {
            startAndStop.setTitle("Stop Music", for: .normal)
            
            let url = Bundle.main.url(forResource: "alarm", withExtension: "wav")
            alarm = try! AVAudioPlayer(contentsOf: url!)
            alarm.play()
            countdownTimer?.invalidate()
        }
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        return " \(seconds/3600) : \((seconds % 3600) / 60) : \((seconds % 3600) % 60)"
    }
    
}


