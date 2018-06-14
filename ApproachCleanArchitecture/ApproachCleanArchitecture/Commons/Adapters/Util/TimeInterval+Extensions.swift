//
//  TimeInterval+Extensions.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/14/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    var minuteSecondMS: String {
        
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    
    var minute: Int {
        
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    
    var second: Int {
        
        return Int(truncatingRemainder(dividingBy: 60))
    }
    
    var millisecond: Int {
        
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    
    var msToSeconds: Double {
    
        return Double(self) / 1000
    }
}
