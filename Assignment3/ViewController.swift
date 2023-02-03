//
//  ViewController.swift
//  Assignment3
//
//  Created by Ross Farmer on 1/30/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
        setBackground()
    }

    @objc func currentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        clock.text = formatter.string(from: Date())
        }
    
    @objc func setBackground(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        if(hour > 11){
            background.image = UIImage(named:"PM")
            background.contentMode = UIView.ContentMode.scaleAspectFill
        } else {
            background.image = UIImage(named:"AM")
            background.contentMode = UIView.ContentMode.scaleAspectFill
        }
    }
}


