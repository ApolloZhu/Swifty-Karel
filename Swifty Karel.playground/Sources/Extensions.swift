import Foundation
import UIKit

extension Int {
    public static func random(from start: Int, to end: Int) -> Int {
        return Int(arc4random_uniform(UInt32(end)))*(end-start)+start
    }
    public static func random(from start: Int, through end: Int) -> Int {
        return random(from: start, to: end+1)
    }
}

extension UIColor {
    public static let tianyi = UIColor(red: 0.4, green: 0.8, blue: 1, alpha: 1)
}

extension CGSize {
    public init<T: Integer>(side: T) {
        self.init(width: side as! Int, height: side as! Int)
    }
    public init<T: FloatingPoint>(side: T) {
        self.init(width: side as! Double, height: side as! Double)
    }
}

public enum MapDirection: Int {
    case north, east, south, west
    mutating func turnLeft() {
        switch self {
        case .north: self = .west
        case .east: self = .north
        case .south: self = .east
        case .west: self = .south
        }
    }
    mutating func turnRight() {
        switch self {
        case .north: self = .east
        case .east: self = .south
        case .south: self = .west
        case .west: self = .north
        }
    }
    func mapDirection(whenFacing direction: Direction) -> MapDirection {
        // We are always facing front
        return MapDirection(rawValue: (rawValue + direction.rawValue) % 4)!
    }
}

public enum Direction: Int {
    case front,right,back,left
}

public struct Point {
    public static let zero = Point(0,0)
    public var x, y: Int
    init(_ x: Int = 0, _ y: Int = 0) { self.x = abs(x);self.y = abs(y) }
    init(_ point: CGPoint) { self.init(Int(point.x),Int(point.y)) }
}

enum KarelError: Error {
    case beenBlocked(at: Point, facing: MapDirection)
    case noBeeper
}

extension Error {
    func show() {
        Playground.current.showError(self)
    }
}
