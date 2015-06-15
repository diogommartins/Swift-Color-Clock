//
//  DMClock.swift
//  Swift Color Clock
//
//  Created by Diogo Martins on 6/15/15.
//  Copyright (c) 2015 Diogo Martins. All rights reserved.
//

import UIKit

protocol DMClockDelegate {
    func clockDidUpdate()
}

class DMClock: NSObject {
    var hours:Int
    var minutes:Int
    var seconds:Int
    var timer:NSTimer
    var interval:Float = 1.0
    var delegate:DMClockDelegate?
    
    init(interval:Float?, delegate:DMClockDelegate?){
        self.interval = interval!
        self.delegate = delegate
        self.timer = NSTimer()
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
    }
    
    func start(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(self.interval), target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    func stop(){
        self.timer.invalidate()
    }
    
    func update(){
        let date = NSDate()
        
        self.hours = self.timePieceWithFormat("HH", date: date)
        self.minutes = self.timePieceWithFormat("mm", date: date)
        self.seconds = self.timePieceWithFormat("ss", date: date)
        self.delegate?.clockDidUpdate()
    }
    
    private func timePieceWithFormat(format:String, date:NSDate) -> Int{
        let formater:NSDateFormatter = NSDateFormatter()
        formater.dateFormat = format
        
        return formater.stringFromDate(date).toInt()!
    }
}
