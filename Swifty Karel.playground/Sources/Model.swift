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
    public let facing: GeologicalDirection
}

public class WorldModel {
    public fileprivate(set) var streetsCount: Int
    public fileprivate(set) var avenuesCount: Int
    public fileprivate(set) var karel = KarelModel(point: .origin, facing: .east)
    public fileprivate(set) var beepers = [BeeperModel]()
    public fileprivate(set) var walls = [WallModel]()
    public fileprivate(set) var colored = [ColorModel]()
    public init(streets: Int, avenues: Int) {
        streetsCount = streets
        avenuesCount = avenues
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
    public func makeKarel(at corner: Point, facing geologicalDirection: GeologicalDirection) -> WorldModel {
        if isValid(corner: corner) {
            karel = KarelModel(point: corner, facing: geologicalDirection)
        }
        return self
    }
    @discardableResult
    public func setBeeperCount(for corner: Point, to count: Int) -> WorldModel {
        if count > 0 && isValid(corner: corner) {
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
    public func save(withName name: String)  -> WorldModel {
        /*
         Sc Ac Kx Ky Kf
         Bx By Bc
         ...
         Wx1 Wy1 Wx2 Wy2
         ...
         */
        var out = "\(streetsCount) \(avenuesCount) \(karel.point) \(karel.facing.rawValue)\n"
        for beeper in beepers {
            out += "\(beeper.corner) \(beeper.count)\n"
        }
        for wall in walls {
            out += "\(wall.start) \(wall.end)\n"
        }
        for block in colored {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            block.color.getRed(&r, green: &g, blue: &b, alpha: &a)
            out += "\(block.corner) \(r) \(g) \(b) \(a)\n"
        }
        do {
            let url = name.karelWorldURL
            try out.write(to: url, atomically: true, encoding: .utf8)
            Playground.current.showInfo("Saved to \(url.absoluteURL)")
        } catch {
            error.show()
        }
        return self
    }

    public class func named(_ name: String) -> WorldModel? {
        guard let source = try? String(contentsOf: name.karelWorldURL) else { return nil }
        return byParsing(source)
    }
    static func byParsing(_ source: String) -> WorldModel? {
        let lines = source.components(separatedBy: .newlines)

        guard let info = lines.first?.components(separatedBy: " ").flatMap({ Int($0) }),
            info.count == 5, let direction = GeologicalDirection(rawValue: info[4]) else { return nil }

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

extension WorldModel: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        let view = WorldView(model: self, in: CGRect(origin: .zero, size: CGSize(side: 400)))
        view.layout()
        view.karelView.image = Playground.current.karelImage
        return .view(view)
    }
}

extension String {
    var karelWorldURL: URL {
        return URL(fileURLWithPath: "\(self).karelWorld")
    }
}
