import Foundation
import UIKit

/// Move Karel forward 1 block in current direction
public func move() {
    Karel.current.move()
}

/// Turn Karel counter-clockwise by 90 degree
public func turnLeft() {
    Karel.current.turnLeft()
}

/// Pick up one beeper at Karel's current location
public func pickBeeper() {
    Karel.current.pickBepper()
}

/// Put one beeper at Karel's current location
public func putBeeper() {
    Karel.current.putBeeper()
}

// MARK: World Related
//var position: Point { get set }
//var direction: MapDirection { get set }

public var isOnBeeper: Bool {
    return Karel.current.isOnBeeper
}

public var isBlocked: Bool {
    return Karel.current.isBlocked
}

public func isClear(at direction: Direction) -> Bool {
    return Karel.current.isClear(at: direction)
}

public func isBlocked(at direction: Direction) -> Bool {
    return Karel.current.isBlocked(at: direction)
}

public func isFacing(_ direction: MapDirection) -> Bool{
    return Karel.current.isFacing(direction)
}

public func isNotFacing(_ direction: MapDirection) -> Bool{
    return Karel.current.isNotFacing(direction)
}

//-conditional
public func turnRight() {
    Karel.current.turnRight()
}

public func turnAround() {
    Karel.current.turnAround()
}
//-end-conditional

public func paintBlock(color: UIColor) {
    Karel.current.paintBlock(color: color)
}

public var colorOfBlock: UIColor {
    return Karel.current.colorOfBlock
}

public func exec() {
    
}
