import PlaygroundSupport
import UIKit
import Foundation

public struct WallModel {
    public let start, end: Point
}

public struct BeeperModel {
    public let corner: Point
    public let count: Int
}

public struct ColorModel {
    public let corner: Point
    public let color: UIColor
}

public struct KarelModel {
    public let point: Point
    public let facing: CompassDirection
}

public class WorldModel {
    static let invalid = WorldModel(streets: 0, avenues: 0)
    public fileprivate(set) var streetsCount: Int
    public fileprivate(set) var avenuesCount: Int
    public fileprivate(set) var karelModel = KarelModel(point: .origin, facing: .east)
    public fileprivate(set) var beepers = [BeeperModel]()
    public fileprivate(set) var walls = [WallModel]()
    public fileprivate(set) var colored = [ColorModel]()
    public init(streets: Int, avenues: Int) {
        streetsCount = streets
        avenuesCount = avenues
    }
    public func copy() -> WorldModel {
        let model = WorldModel(streets: streetsCount, avenues: avenuesCount)
        for wall in walls {
            model.addWall(from: wall.start, to: wall.end)
        }
        return model
    }
}

extension WorldModel {
    private func isValid(corner: Point) -> Bool {
        return corner.x >= 1 && corner.y >= 1 && corner.x <= streetsCount && corner.y <= avenuesCount
    }
    private func isValid(wall: Point) -> Bool {
        return wall.x >= 0 && wall.y >= 0 && wall.x <= streetsCount && wall.y <= avenuesCount
    }
    private func onEdge(wall: Point) -> Bool {
        return wall.x == 0 || wall.y == 0 || wall.x == streetsCount || wall.y == avenuesCount
    }
    @discardableResult
    public func makeKarel(at corner: Point, facing compassDirection: CompassDirection) -> WorldModel {
        if isValid(corner: corner) {
            karelModel = KarelModel(point: corner, facing: compassDirection)
        }
        return self
    }
    @discardableResult
    public func setBeeperCount(for corner: Point, to count: Int) -> WorldModel {
        if isValid(corner: corner) {
            beepers.append(BeeperModel(corner: corner, count: count))
        }
        return self
    }
    @discardableResult
    public func addWall(from start: Point, to end: Point) -> WorldModel {
        if ((start.x == end.x) ^ (start.y == end.y))
            && isValid(wall: start) && isValid(wall: end)
            && (onEdge(wall: start) ^ onEdge(wall: end)) {
            if start.x < end.x || start.y < end.y {
                walls.append(WallModel(start: start, end: end))
            } else {
                walls.append(WallModel(start: end, end: start))
            }
        }
        return self
    }
    @discardableResult
    public func setColor(_ color: UIColor, for corner: Point) -> WorldModel {
        if isValid(corner: corner) {
            colored.append(ColorModel(corner: corner, color: color))
        }
        return self
    }
    /*
     Sc Ac Kx Ky Kf
     Bx By Bc
     ...
     Wx1 Wy1 Wx2 Wy2
     ...
     */
    public var ascii: String {
        var out = "\(streetsCount) \(avenuesCount) \(karelModel.point.debugDescription) \(karelModel.facing.rawValue)\n"
        for beeper in beepers {
            out += "\(beeper.corner.debugDescription) \(beeper.count)\n"
        }
        for wall in walls {
            out += "\(wall.start.debugDescription) \(wall.end.debugDescription)\n"
        }
        for block in colored {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            block.color.getRed(&r, green: &g, blue: &b, alpha: &a)
            out += "\(block.corner.debugDescription) \(r) \(g) \(b) \(a)\n"
        }
        return out
    }
    public func save(withName name: String)  -> CachedViewable {
        do {
            let url = name.karelWorldURL
            try ascii.write(to: url, atomically: true, encoding: .utf8)
            karel.alert("Saved to \(url.absoluteURL)")
            return CachedViewable(content: quickLookView, path: url.path)
        } catch {
            return CachedViewable(content: quickLookView, path: error.localizedDescription)
        }
    }
    public class func named(_ name: String) -> WorldModel? {
        guard let source = try? String(contentsOf: name.karelWorldURL) else { return nil }
        return byParsing(source)
    }
    public static func byParsing(_ source: String) -> WorldModel? {
        let lines = source.components(separatedBy: .newlines)
        
        guard let info = lines.first?.components(separatedBy: " ").flatMap({ Int($0) }),
            info.count == 5, let direction = CompassDirection(rawValue: info[4]) else { return nil }
        
        let world = WorldModel(streets: info[0], avenues: info[1]).makeKarel(at: Point(info[2],info[3]), facing: direction)
        
        lines.lazy.forEach {
            let info = $0.components(separatedBy: .whitespaces).flatMap { Double($0) }
            switch info.count {
            case 3:
                world.setBeeperCount(for: Point(info[0], info[1]), to: Int(info[2]))
            case 4:
                world.addWall(from: Point(info[0], info[1]), to: Point(info[2], info[3]))
            case 6:
                world.setColor(UIColor(red: CGFloat(info[2]), green: CGFloat(info[3]), blue: CGFloat(info[4]), alpha: CGFloat(info[5])), for: Point(info[0], info[1]))
            default: break
            }
        }
        return world
    }
}

extension String {
    var karelWorldURL: URL {
        return URL(fileURLWithPath: "\(self).karelWorld")
    }
}
