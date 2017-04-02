import Foundation
import UIKit

extension UIColor {
    public static let tianyi = UIColor(red: 0.4, green: 0.8, blue: 1, alpha: 1)
    public static let background = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
}

extension CGSize {
    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}

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

public struct Point: CustomStringConvertible {
    public static let zero = Point(0,0)
    public static let origin = Point(1,1)
    public internal(set) var x, y: Int

    public init(_ x: Int = 0, _ y: Int = 0) {
        self.x = abs(x)
        self.y = abs(y)
    }
    public init(_ x: CGFloat = 0, _ y: CGFloat = 0) {
        self.init(Int(x), Int(y))
    }
    public init(_ point: CGPoint) {
        self.init(point.x,point.y)
    }
    public init(_ x: Double, _ y: Double) {
        self.init(Int(x), Int(y))
    }
    public var description: String {
        return "\(x) \(y)"
    }
    public func cgPoint(scaledBy scale: CGFloat = 1) -> CGPoint {
        return CGPoint(x: scale*CGFloat(x), y: scale*CGFloat(y))
    }
}

enum KarelError: Error {
    case beenBlocked(at: Point, facing: GeologicalDirection)
    case noBeeper
    var localizedDescription: String {
        switch self {
        case .noBeeper:
            return "Karel is trying to pick up nothing"
        case .beenBlocked(let point, facing):
            return "Karel is blocked at (\(point.x), \(point.y)), facing \(facing)"
        default:
            return "Karel is %^$#$*#^$&"
        }
    }
}

extension Error {
    func show() {
        Playground.current.showError(self)
    }
}

extension Bool {
    static func ^(lhs: Bool, rhs: Bool) -> Bool {
        return lhs != rhs
    }
}

protocol Coordinated {
    var street: Int { get }
    var avenue: Int { get }
}

extension Coordinated where Self: UIView {
    func showCoordinate(autoHide: Bool = false) {
        let label = UILabel()
        label.text = "(\(street), \(avenue))"
        label.frame = CGRect(origin: .zero, size: CGSize(side: frame.width))
        label.textAlignment = .center
        addSubview(label)
        if autoHide {
            UIView.animate(withDuration: Playground.current.duration, delay: Playground.current.duration * 3, animations: {
                label.removeFromSuperview()
            })
        }
    }
}

