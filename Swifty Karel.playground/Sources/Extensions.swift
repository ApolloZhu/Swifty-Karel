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

extension UIEdgeInsets {
    public init(side: CGFloat) {
        self.init(top: side, left: side, bottom: side, right: side)
    }
}

extension CGRect {
    func max(ratio: Point, insect: UIEdgeInsets = .zero) -> (frame: CGRect, side: CGFloat) {
        let w = width - insect.left - insect.right
        let h = height - insect.top - insect.bottom
        let c_x = CGFloat(ratio.x)
        let c_y = CGFloat(ratio.y)
        let side = min(w/c_x,h/c_y)
        let aW = side * c_x
        let aH = side * c_y
        return (CGRect(x: midX - aW/2, y: midY - aH/2, width: aW, height: aH), side)
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

public struct Point: CustomStringConvertible, CustomDebugStringConvertible {
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
    func showCoordinates(autoHide: Bool = false) {
        let label = UILabel()
        label.text = "(\(street), \(avenue))"
        label.frame = CGRect(origin: .zero, size: CGSize(side: frame.width))
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
