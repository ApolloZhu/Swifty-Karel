//
//  Block.swift
//  SwiftyKarel
//
//  Created by Apollonian on 10/10/16.
//
//

import Foundation
import UIKit

public class Block {
    var street, avenue: Int
    var blocked: [MapDirection]
    var color: CGColor?
    init(street: Int, avenue: Int, color: CGColor? = nil, blockedInDirections directions: [MapDirection] = [MapDirection]()) {
        self.street = street
        self.avenue = avenue
        self.color = color
        blocked = directions
    }
    convenience init(_ point: Point, color: CGColor? = nil, blockedInDirections directions: [MapDirection] = [MapDirection]()) {
        self.init(street:point.x,avenue:point.y, color: color, blockedInDirections: directions)
    }
}
