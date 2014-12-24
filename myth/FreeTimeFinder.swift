//
//  FreeTimeFinder.swift
//  myth
//
//  Created by PASCAL ARINGO ODEK on 12/23/14.
//  Copyright (c) 2014 Pascal Odek. All rights reserved.
//

import UIKit
import EventKit

class FreeTimeFinder: NSObject {
    var eventsAccessGranted = false
    var eventStore = EKEventStore()
    var curTime: NSDate {
        return NSDate()
    }
    var endTime: NSDate {
        return curTime.dateByAddingTimeInterval(60 * 60 * 24) //60s/min * 60 min/hr * 24 hours/day
    }
    
    var freeIntervals: [FreeInterval]?
    
    convenience init(granted: Bool) {
        self.init()
        self.eventsAccessGranted = granted
        self.getFreeIntervals()
    }
    
    
    
    //Later sort this array if needed.
    func coalesced(intervals: [FreeInterval]) -> [FreeInterval] {
        var coalescedArray = intervals
        var i = 0
        while(i < coalescedArray.count) {
            var j = i + 1
            if j >= coalescedArray.count {
                break
            }
            var endDate1 = coalescedArray[i].date2
            var startDate2 = coalescedArray[j].date1
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let t1 = dateFormatter.stringFromDate(endDate1)
            let t2 = dateFormatter.stringFromDate(startDate2)
            if t1 == t2 {
                var newInterval = FreeInterval(date1: coalescedArray[i].date1, date2: coalescedArray[j].date2)
                coalescedArray.removeAtIndex(j)
                coalescedArray[i] = newInterval
            } else {
                i++
            }
        }
        return coalescedArray
    }
    
    
    func getFreeIntervals() -> [FreeInterval]? {
        //if(self.eventsAccessGranted) {
        var timePeriod = eventStore.predicateForEventsWithStartDate(curTime, endDate: endTime, calendars: nil)
        if timePeriod == nil {
            println("Oh")
        }
        var freeTimes = [FreeInterval]()
        if let busyEvents = eventStore.eventsMatchingPredicate(timePeriod) {
            var busyIntervals = [FreeInterval]()
            for event in busyEvents {
                busyIntervals.append(FreeInterval(date1: event.startDate, date2: event.endDate))
            }
            //For every 15 minutes, find free times.  MAKE A MORE EFFICIENT ALGORITHM LATER
            var intervalFree = true
            for(var i:Int = 0; i < 24 * 15 * 60 * 4 ; i += 15 * 60) {
                var timePastNow = NSTimeInterval(i)
                var nextTime = curTime.dateByAddingTimeInterval(timePastNow)
                var nextInterval = FreeInterval(date1: nextTime, date2: nextTime.dateByAddingTimeInterval(15 * 60))
                intervalFree = true
                for busyInterval in busyIntervals {
                    if  busyInterval.containsInterval(nextInterval) {
                        intervalFree = false
                    }
                }
                if(intervalFree) {
                    freeTimes.append(nextInterval as FreeInterval)
                }
            }
            freeTimes = self.coalesced(freeTimes)
        } else {
            println("FUUU")
            return [FreeInterval(date1: curTime, date2: endTime)]
        }
        /*} else {
        println("no events access")
        freeIntervals = nil
        }*/
        self.freeIntervals = freeTimes
        return freeTimes
    }
}
                                                                                                                                                                                          