import Foundation

extension Int{
    public static func random(from start: Int, to end: Int) -> Int{
        return Int(arc4random_uniform(UInt32(end)))*(end-start)+start
    }
    public static func random(from start: Int, through end: Int) -> Int{
        return random(from: start, to: end+1)
    }
}

import Foundation
import UIKit

public enum Direction: Int {
    case north, east, south, west
    case none
    init(_ string: String) {
        switch string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
        case "n", "north":
            self = .north
        case "e", "east":
            self = .east
        case "s", "south":
            self = .south
        case "w", "west":
            self = .west
        default:
            self = .none
        }
    }
}

public enum Position: Int {
    case front,right,back,left
    case none
}

public struct Point{
    public let x, y: Int
    init(_ x: Int = 0, _ y: Int = 0) { self.x = x;self.y = y }
    init(_ point: CGPoint) { self.init(Int(point.x),Int(point.y)) }
}
