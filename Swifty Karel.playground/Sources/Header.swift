import Foundation
import UIKit

/// Karel the robot.
var karel: Karel {
    return Playground.current.worldView.karelView
}

/// Move Karel forward 1 block in current direction.
public func move() {
    karel.move()
}

/// Turn Karel counter-clockwise by 90 degree.
public func turnLeft() {
    karel.turnLeft()
}

/// Pick up one beeper at Karel's current location.
public func pickBeeper() {
    karel.pickBepper()
}

/// Put one beeper at Karel's current location.
public func putBeeper() {
    karel.putBeeper()
}

/// The position karel is at in the world.
public var position: Point {
    return karel.position
}

/// The geological direction karel is currently facing, either north, east, south, or west.
public var facing: GeologicalDirection {
    return karel.facing
}

/// If karel is on beeper.
public var isOnBeeper: Bool {
    return karel.isOnBeeper
}

/// If karel is blocked by a wall in front.
public var isBlocked: Bool {
    return karel.isBlocked
}

/// Check if karel can move to the given direction
///
/// - Parameter direction: a direction relative to karel to check, either front, right, back, or left.
/// - Returns: if karel is not blocked at `direction`.
public func isClear(at direction: Direction) -> Bool {
    return karel.isClear(at: direction)
}

/// Check if karel can't move to the given direction
///
/// - Parameter direction: a direction relative to karel to check, either front, right, back, or left.
/// - Returns: if karel is blocked at `direction`.
public func isBlocked(at direction: Direction) -> Bool {
    return karel.isBlocked(at: direction)
}

/// Check if karel is facing the given geological direction
///
/// - Parameter direction: a geological location to check, either north, east, south, or west.
/// - Returns: if karel is facing `direction`
public func isFacing(_ direction: GeologicalDirection) -> Bool{
    return karel.isFacing(direction)
}

/// Check if karel is not facing the given geological direction
///
/// - Parameter direction: a geological location to check, either north, east, south, or west.
/// - Returns: if karel is not facing `direction`
public func isNotFacing(_ direction: GeologicalDirection) -> Bool{
    return karel.isNotFacing(direction)
}

/// Turn Karel clockwise by 90 degree.
public func turnRight() {
    karel.turnRight()
}

/// Turn Karel by 180 degree.
public func turnAround() {
    karel.turnAround()
}

/// Paint the corner that karel is on to the given color
///
/// - Parameter color: color to paint the block to
public func paintCorner(color: UIColor) {
    karel.paintBlock(color: color)
}

/// The color of the corner that karel is on
public var colorOfCorner: UIColor {
    return karel.colorOfBlock
}

/// Generates a random number in the given range
///
/// - Parameters:
///   - start: start of the range
///   - end: end of the range, not included in the range
/// - Returns: a random integer with in start..<end
public func randomInt(startingFrom start: Int, toBefore end: Int) -> Int {
    let MAX = max(start, end)
    let MIN = min(start, end)
    return Int(arc4random_uniform(UInt32(MAX)))*(MAX-MIN)+MIN
}

/// Generates a random number in the given range
///
/// - Parameters:
///   - start: start of the range
///   - end: end of the range, included in the range
/// - Returns: a random integer with in start...end
public func randomInt(between start: Int, and end: Int) -> Int {
    let MAX = max(start, end)
    let MIN = min(start, end)
    return randomInt(startingFrom: MIN, toBefore: MAX+1)
}
