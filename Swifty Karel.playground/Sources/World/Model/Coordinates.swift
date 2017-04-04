import UIKit

public enum GeologicalDirection: Int {
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
    func geologicalDirection(whenFacing direction: Direction) -> GeologicalDirection {
        // We are always facing front
        return GeologicalDirection(rawValue: (rawValue + direction.rawValue) % 4)!
    }
}

public enum Direction: Int {
    case front,right,back,left
}

public struct Point: CustomStringConvertible, CustomDebugStringConvertible {
    public static let zero = Point()
    public static let origin = Point(1,1)
    public internal(set) var x, y: Int

    public init(_ x: Int = 0, _ y: Int = 0) {
        self.x = abs(x)
        self.y = abs(y)
    }
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init(Int(x), Int(y))
    }
    public init(_ point: CGPoint) {
        self.init(point.x, point.y)
    }
    public init(_ x: Double, _ y: Double) {
        self.init(Int(x), Int(y))
    }
    public var debugDescription: String {
        return "\(x) \(y)"
    }
    public var description: String {
        return "(\(x), \(y))"
    }
    public func cgPoint(scaledBy scale: CGFloat = 1) -> CGPoint {
        return CGPoint(x: scale*CGFloat(x), y: scale*CGFloat(y))
    }
}

protocol Coordinated {
    var street: Int { get }
    var avenue: Int { get }
}

extension Coordinated where Self: UIView {
    func showCoordinates(autoHide: Bool = false) {
        let label = UILabel()
        label.text = "(\(street), \(avenue))"
        label.frame = CGRect(x: 0, y: bounds.maxY - 50, width: bounds.width, height: 50)
        label.textColor = Playground.current.colorScheme.cornerCoordinatesColor
        label.textAlignment = .center
        label.tag = Playground.identifier
        addSubview(label)
        if autoHide {
            UIView.animate(withDuration: Playground.current.duration, delay: Playground.current.duration * 3, animations: {
                label.removeFromSuperview()
            })
        }
    }

    func removeCoordinates() {
        subviews.lazy.forEach {
            if $0.tag == Playground.identifier {
                $0.removeFromSuperview()
            }
        }
    }
}
