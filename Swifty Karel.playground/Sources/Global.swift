import Foundation
import UIKit

/// Move Karel forward 1 block in current direction
func move() {
    Karel.current?.move()
}

/// Turn Karel counter-clockwise by 90 degree
func turnLeft() {
    Karel.current?.turnLeft()
}

/// Pick up one beeper at Karel's current location
func pickBeeper() {
    Karel.current?.pickBeeper()
}

/// Put one beeper at Karel's current location
func putBeeper() {
    Karel.current?.putBeeper()
}

// MARK: World Related
//var position: Point { get set }
//var direction: MapDirection { get set }

var isOnBeeper: Bool {
    return Karel.current?.isOnBeeper ?? false
}

var isBlocked: Bool {
    return Karel.current?.isBlocked ?? false
}

func isClear(at direction: Direction) -> Bool {
    return Karel.current?.isClear(at: direction) ?? true
}

func isBlocked(at direction: Direction) -> Bool {
    return Karel.current?.isBlocked(at: direction) ?? false
}

func isFacing(_ direction: MapDirection) -> Bool{
    return Karel.current?.isFacing(direction) ?? false
}

func isNotFacing(_ direction: MapDirection) -> Bool{
    return Karel.current?.isNotFacing(direction) ?? true
}

//-conditional
func turnRight() {
    Karel.current?.turnRight()
}

func turnAround() {
    Karel.current?.turnAround()
}
//-end-conditional

func paintBlock(color: UIColor) {
    Karel.current?.paintBlock(color: color)
}

var colorOfBlock: UIColor {
    return Karel.current?.colorOfBlock ?? .clear
}
