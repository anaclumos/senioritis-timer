//
//  ViewController.swift
//  senioritis
//
//  Created by Sunghyun Cho on 01/09/2019.
//  Copyright © 2019 Sunghyun Cho. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timeField: NSTextField!
    @IBOutlet weak var timeDisplay: NSTextField!
    
    var hour = 0
    var minute = 0
    var second = 0
    var minuteString = ""
    var secondString = ""
    
    var timer = Timer()
    var timerON: Bool = false
    
    override func viewDidLoad() {super.viewDidLoad()}
    override var representedObject: Any? {didSet {}}
    
    @IBAction func setButtonClicked(_ sender: Any) {
        if !timerON {
            timerON = true
            let time = timeField.stringValue
            formatSecondToTime(s: time)
            displayTime()
            runTimer()
        }
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        endTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer (
            timeInterval: 1,
            target: self,
            selector: #selector(ViewController.updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateTimer() {
        print("\(hour):\(minute):\(second)")
        reduceTime()
        displayTime()
    }
    
    func formatSecondToTime(s: String) {
        let sec = Int(s)
        hour = (sec!/3600)
        minute = (sec!%3600)/60
        second = (sec!%60)
    }
    
    func reduceTime() {
        if(second == 0){
            if(minute == 0){
                if(hour == 0){
                    endTimer()
                } else {
                    hour -= 1
                    minute = 59
                    second = 60
                }
            } else {
                minute -= 1
                second = 60
            }
        }
        second -= 1
    }
    
    func displayTime() {
        
        if(minute < 10) {
            minuteString = "0\(minute)"
        } else {
            minuteString = String(minute)
        }
        
        if(second < 10) {
            secondString = "0\(second)"
        } else {
            secondString = String(second)
        }
        
        timeDisplay.stringValue = "\(hour):\(minuteString):\(secondString)"
    }
    
    func endTimer() {
        hour = 0; minute = 0; second = 0;
        timer.invalidate()
        timerON = false
        displayTime()
    }
}

