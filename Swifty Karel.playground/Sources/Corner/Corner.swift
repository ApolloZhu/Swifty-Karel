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
    private(set) var beeperView = BeeperView()
    var street, avenue: Int
    public private(set) var blocked: [MapDirection]?

    public init(street: Int, avenue: Int, size: Int = 0, backgroundColor: UIColor? = nil, blockedInDirections directions: [MapDirection]? = nil) {
        self.street = street
        self.avenue = avenue
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        self.backgroundColor = backgroundColor
        blocked = directions
    }

    convenience public init(_ point: Point, size: Int = 0,backgroundColor: UIColor? = nil, blockedInDirections directions: [MapDirection]? = nil) {
        self.init(street:point.x,avenue:point.y, size:size, backgroundColor: backgroundColor, blockedInDirections: directions)
    }

    required public init?(coder aDecoder: NSCoder) {
        street = 0
        avenue = 0
        super.init(coder: aDecoder)
    }

    public func block(directions: MapDirection...) {
        if blocked != nil {
            blocked!.append(contentsOf: directions)
        } else {
            blocked = directions
        }
    }
}
