//
//  Corner.swift
//  SwiftyKarel
//
//  Created by Apollonian on 10/10/16.
//
//

import Foundation
import UIKit

public class Corner: UIView {
    private var beeperView = BeeperView()
    var street, avenue: Int
    public private(set) var blocked: [GeologicalDirection]?

    public var borderColor: UIColor = .tianyi {
        didSet {
            layer.borderColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }

    public var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }

    public init(street: Int, avenue: Int, frame: CGRect, backgroundColor: UIColor? = .white, blockedInDirections directions: [GeologicalDirection]? = nil) {
        self.street = street
        self.avenue = avenue
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        blocked = directions
        layer.borderColor = borderColor.cgColor
    }

    convenience public init(_ point: Point, frame: CGRect, backgroundColor: UIColor? = .white, blockedInDirections directions: [GeologicalDirection]? = nil) {
        self.init(street:point.x,avenue:point.y, frame: frame, backgroundColor: backgroundColor, blockedInDirections: directions)
    }

    required public init?(coder aDecoder: NSCoder) {
        street = 0
        avenue = 0
        super.init(coder: aDecoder)
    }

    public var beeperCount: Int {
        return Int(beeperView.beeperCount)
    }

    public func pickBeeper() throws {
        if beeperView.beeperCount == 0 {
            throw KarelError.noBeeper
        }
        beeperView.beeperCount -= 1
    }

    public func putBeeper() {
        beeperView.beeperCount += 1
    }

    public func block(directions: GeologicalDirection...) {
        if blocked != nil {
            blocked!.append(contentsOf: directions)
        } else {
            blocked = directions
        }
        setNeedsDisplay()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let blocked = blocked else { return }
        let path = UIBezierPath()
        for direction in blocked {
            switch direction {
            case .north:
                path.move(to: frame.origin)
                path.addLine(to: CGPoint(x: frame.maxX, y: frame.minY))
            case .east:
                path.move(to: CGPoint(x: frame.maxX, y: frame.minY))
                path.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))
            case .south:
                path.move(to: CGPoint(x: frame.minX, y: frame.maxY))
                path.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))
            case .west:
                path.move(to: frame.origin)
                path.addLine(to: CGPoint(x: frame.minX, y: frame.maxY))
            }
        }
        path.lineWidth = borderWidth * 3
        borderColor.setStroke()
        path.stroke()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let label = UILabel()
        label.text = "(\(street), \(avenue))"
        addSubview(label)
        UIView.animate(withDuration: Playground.current.duration, delay: Playground.current.duration * 3, animations: {
            label.removeFromSuperview()
        })
    }
}
