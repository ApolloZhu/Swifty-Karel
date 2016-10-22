//
//  AZKarel.swift
//  SwiftyKarel
//
//  Created by Apollonian on 10/10/16.
//
//

/// Basic functionality of Karel
public protocol Karel{
    /// Move Karel forward 1 block in current direction
    func move() throws
    /// Turn Karel counterclockwise by 90 degree
    func turnLeft()
    /// Pick up one beeper at Karel's current location
    func pickBeeper() throws
    /// Put one beeper at Karel's current location
    func putBeeper()

    // MARK: World Related
    var position: Point { get set }
    var direction: Direction { get set }

    var isOnBeeper: Bool { get }
    var isBlocked: Bool { get }
    func isClearIn(_ position: Position) -> Bool
    func isBlockedIn(_ position: Position) -> Bool
}

extension Karel{
    func isFacing(_ direction: Direction) -> Bool{
        return self.direction == direction
    }
    func isNotFacing(_ direction: Direction) -> Bool{
        return !isFacing(direction)
    }
}

public protocol KarelDelegate{
    var karel: Karel { get set }
}

public protocol SuperKarel: Karel{
    func move()
    func turnRight()
    func turnAround()
    func pickBepper(count: Int)
    func putBeeper(count: Int)

    func paintBlock(color:CGColor)
    var colorOfBlock: CGColor { get }
}

enum KarelError: Error{
    case beenBlocked
    case noBeeper
}
