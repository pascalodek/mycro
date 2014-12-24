//
//  FreeInterval.swift
//  myth
//
//  Created by PASCAL ARINGO ODEK on 12/22/14.
//  Copyright (c) 2014 Pascal Odek. All rights reserved.
//

import Foundation

class FreeInterval {
    //An interval is a time period between 2 dates.
    
    //properties
    var date1 : NSDate //start date
    var date2 : NSDate //end date
    var lengthMinutes : Int {
        var timeIntervalSeconds = date2.timeIntervalSinceDate(date1)
        return Int(timeIntervalSeconds) / 60
    }
    var invitedFriends : [String] = []
    
    var assignedTask: Task?
    
    var chosen: Bool { //has atask been chosen for this period?
        if assignedTask != nil {
            return true
        }
        return false
    }
    
    var minutesUntil: Int {
        
        var secondsUntil = date1.timeIntervalSinceNow
        return Int(secondsUntil) / 60
    }
    //initializer
    init(date1: NSDate, date2: NSDate){
        self.date1 = date1
        self.date2 = date2
    }
    
    //methods
    
    func containTime(date: NSDate) ->Bool {
        
        if(date.timeIntervalSinceDate(self.date1) > 0 && date.timeIntervalSinceDate(self.date2) < 0 ){
            return true
        }
        return false
    }
    func toString() -> String {
         var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "H:mm"
        let t1= dateFormatter.stringFromDate(date1)
        let t2= dateFormatter.stringFromDate(date2)
        return "\(t1) - \(t2)"
        
    }
    
    
    func minutesUntilToString() -> String {
        var minutes = self.minutesUntil % 60
        var hours = self.minutesUntil / 60
        var lengthString = ""
        if self.minutesUntil > 0 {
            if hours == 1{
                lengthString += "1 hour"
            }
            if hours > 1 {
                lengthString += "\(hours) hours"
            }
            if minutes > 0 {
                lengthString += "\(minutes) minutes"
            }
            return "In \(lengthString)"
        }else {
            return "Now"
        }
    }
}
