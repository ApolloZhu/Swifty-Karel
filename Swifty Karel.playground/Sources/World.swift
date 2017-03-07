import Foundation

class World {
    public static let standard = World()

    public private(set) var karel: Karel?
    var coordinate = [[Block]]()
    var beeperLocation = [Block]()
    let width,height: Int

    init() {
        width = 4
        height = 4
        karel = nil
    }

    init(settings: [String:Any]) {
        self.karel = Karel()
        self.width = 1;
        self.height = 2;

        for street in 1...width {
            var row = [Block]()
            for avenue in 1...height {
                row.append(Block(street: street, avenue: avenue))
            }
            coordinate.append(row)
        }
        setWalls()
    }

    func setWalls(_ walls: [Int] = [Int]()) {
        // Around the world
        _ = coordinate[0].map { $0.blocked.append(.north) }
        _ = coordinate[height-1].map { $0.blocked.append(.south) }
        for i in 0..<height {
            coordinate[i][0].blocked.append(.west)
            coordinate[i][width-1].blocked.append(.east)
        }
        // Additional walls
    }

    // MARK: Operate Karel
    func moveKarel(speed: Int) throws {
        
    }
}
