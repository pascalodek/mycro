//
//  Tasklass.swift
//  myth
//
//  Created by PASCAL ARINGO ODEK on 12/22/14.
//  Copyright (c) 2014 Pascal Odek. All rights reserved.
//

import Foundation

class Task {
    
    //properties
    var name : String
    var details : String
    var lengthMinutes : Int
    
    
    
    
    //initializer
    init(name : String, lengthMinutes: Int, details : String){
        self.name = name
        self.details = details
        self.lengthMinutes = lengthMinutes
    }
    
    //methods
    
    func minutesToString()->String {
        var minutes = lengthMinutes % 60
        var hours = lengthMinutes / 60
        var lengthString = ""
        
        if hours == 1 {
            lengthString += "1 hour"
        }
        if hours > 1{
            lengthString += "\(hours) hours"
        }
        if minutes > 0 || hours < 0 {
            lengthString += "\(minutes) minutes"
        }
        return lengthString
    }
    
    
}
