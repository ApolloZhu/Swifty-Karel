import PlaygroundSupport
import Foundation

public struct WallModel {
    public let start, end: Point
}

public struct BeeperModel {
    public let corner: Point
    public let count: Int
}

public struct KarelModel {
    public let point: Point
    public let facing: MapDirection
}

public class WorldModel {
    public fileprivate(set) var streetsCount: Int
    public fileprivate(set) var avenuesCount: Int
    public fileprivate(set) var karel = KarelModel(point: .zero, facing: .east)
    public fileprivate(set) var beepers = [BeeperModel]()
    public fileprivate(set) var walls = [WallModel]()
    public init(streets: Int, avenues: Int) {
        streetsCount = streets
        avenuesCount = avenues
    }
}

extension WorldModel {
    @discardableResult
    public func makeKarel(at corner: Point, facing mapDirection: MapDirection) -> WorldModel {
        if corner.x >= 0 && corner.y >= 0 && corner.x < streetsCount && corner.y < avenuesCount {
            karel = KarelModel(point: corner, facing: mapDirection)
        }
        return self
    }
    @discardableResult
    public func setBeeperCount(for corner: Point, to count: Int) -> WorldModel {
        if count > 0 {
            beepers.append(BeeperModel(corner: corner, count: count))
        }
        return self
    }
    @discardableResult
    public func addWall(from start: Point, to end: Point) -> WorldModel {
        if (start.x == end.x) ^ (start.y == end.y) {
            walls.append(WallModel(start: start, end: end))
        }
        return self
    }
    public func save(withName name: String) {
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
        do {
            let url = name.karelWorldURL
            try out.write(to: url, atomically: true, encoding: .utf8)
            Playground.current.showInfo("Saved to \(url.absoluteURL)")
//            fatalError("Saved to \(url.absoluteURL)")
        } catch {
            error.show()
        }
    }

    public class func named(_ name: String) -> WorldModel? {
        return fromURL(name.karelWorldURL)
    }
    static func fromPath(_ path: String) -> WorldModel? {
        guard let source = try? String(contentsOfFile: path) else { return nil }
        return byParsing(source)
    }
    static func fromURL(_ url: URL) -> WorldModel? {
        guard let source = try? String(contentsOf: url) else { return nil }
        return byParsing(source)
    }
    static func byParsing(_ source: String) -> WorldModel? {
        //TODO: Load world
        let lines = source.components(separatedBy: .newlines)

        guard let info = lines.first?.components(separatedBy: .whitespaces).flatMap({ Int($0) }),
            info.count == 5, let direction = MapDirection(rawValue: info[4]) else { return nil }

        let world = WorldModel(streets: info[0], avenues: info[1]).makeKarel(at: Point(info[2],info[3]), facing: direction)
        lines.lazy.forEach {
            let info = $0.components(separatedBy: .whitespaces).flatMap { Int($0) }
            switch info.count {
            case 3:
                world.setBeeperCount(for: Point(info[0], info[1]), to: info[2])
            case 4:
                world.addWall(from: Point(info[0], info[1]), to: Point(info[2], info[3]))
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
extension Bool {
    static func ^(lhs: Bool, rhs: Bool) -> Bool {
        return lhs != rhs
    }
}

/*
 0  1  2  3
 S+——|——|——+3
 2|  |  |  |
 +——|——|——+2
 1|  |  |  |
 +——|——|——+1
 0|  |  |  |
 +——|——|——+0
 0  1  2 A
 */
