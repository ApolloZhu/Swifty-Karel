import UIKit

class Karel {
    public class var current: Karel? {
        return Playground.current.world?.karel
    }

    weak var world: World?

    func move() {

    }

    func turnLeft() {

    }

    func pickBeeper() {

    }

    func putBeeper() {

    }

    // MARK: World Related
    var position: Point?
    var direction: MapDirection?

    var isOnBeeper: Bool {
        return true
    }
    var isBlocked: Bool {
        return true
    }

    func isClear(at direction: Direction) -> Bool {
        return true
    }

    func isBlocked(at direction: Direction) -> Bool {
        return !isClear(at: direction)
    }

    func turnRight() {

    }

    func turnAround() {

    }

    func pickBepper(count: Int) {

    }

    func putBeeper(count: Int) {

    }

    func isFacing(_ direction: MapDirection) -> Bool {
        return self.direction == direction
    }

    func isNotFacing(_ direction: MapDirection) -> Bool {
        return !isFacing(direction)
    }
    
    func paintBlock(color: UIColor) {
        
    }
    
    var colorOfBlock: UIColor {
        return .clear
    }
}
