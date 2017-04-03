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

extension Bool {
    static func ^(lhs: Bool, rhs: Bool) -> Bool {
        return lhs != rhs
    }
}
extension UIView {
    public func snapshot() -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
