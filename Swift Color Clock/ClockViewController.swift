//
//  ViewController.swift
//  Swift Color Clock
//
//  Created by Diogo Martins on 6/15/15.
//  Copyright (c) 2015 Diogo Martins. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController, DMClockDelegate {
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblMinutes: UILabel!
    @IBOutlet weak var lblSeconds: UILabel!
    @IBOutlet weak var lblHexValue: UILabel!
    
    var clock:DMClock?
    static let MAX_COLOR_VALUE:CGFloat = 255.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clock = DMClock(interval: Float(1.0), delegate: self)
        self.clock!.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateLabels(){
        self.lblHours.text = NSString(format:"%02i", self.clock!.hours) as String
        self.lblMinutes.text = NSString(format:"%02i", self.clock!.minutes) as String
        self.lblSeconds.text = NSString(format:"%02i", self.clock!.seconds) as String
        self.lblHexValue.text = NSString(format: "#%02x%02x%02x", self.clock!.hours, self.clock!.minutes, self.clock!.seconds) as String
    }
    
    private func colorValueFromInt(value:Int, maxValue:Int) -> CGFloat {
        return CGFloat((ClockViewController.MAX_COLOR_VALUE * CGFloat(value)) / CGFloat(maxValue)) / ClockViewController.MAX_COLOR_VALUE;
    }
    
    private func updateBackgroundColor(){
        let red:CGFloat = self.colorValueFromInt(self.clock!.hours, maxValue:24);
        let green:CGFloat = self.colorValueFromInt(self.clock!.minutes, maxValue:60);
        let blue:CGFloat = self.colorValueFromInt(self.clock!.seconds, maxValue:60);

        let color:UIColor = UIColor(red: red, green: green, blue: blue, alpha: 10.0);
        self.view.backgroundColor = color;
    }

    func clockDidUpdate() {
        self.updateLabels()
        self.updateBackgroundColor()
    }

}

