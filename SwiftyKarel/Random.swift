//
//  Random.swift
//  SwiftyKarel
//
//  Created by Apollonian on 10/10/16.
//
//

import Foundation

extension Int{
    public static func random(from start: Int, to end: Int) -> Int{
        return Int(arc4random_uniform(UInt32(end)))*abs(end-start)+Swift.min(start,end)
    }
    public static func random(from start: Int, through end: Int) -> Int{
        return random(from: Swift.min(start,end), to: Swift.max(start,end)+1)
    }
}
