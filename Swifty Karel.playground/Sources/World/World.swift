import Foundation

class World {
    public static var current: World? {
        return Playground.current.world
    }

    public private(set) var karel: Karel?
    var coordinate = [[Corner]]()
    var beeperLocations = [Corner]()
    var streets, avenues: Int

    init() {
        streets = 4
        avenues = 4
        karel = nil
    }

    init(settings: [String:Any]) {
        self.karel = Karel()
        self.streets = 1;
        self.avenues = 2;

        for street in 1...streets {
            var row = [Corner]()
            for avenue in 1...avenues {
                row.append(Corner(street: street, avenue: avenue))
            }
            coordinate.append(row)
        }
        setWalls()
    }

    func setWalls(_ walls: [Int] = [Int]()) {
        // Around the world
        coordinate[0].forEach { $0.block(directions: .north) }
        coordinate[avenues-1].forEach { $0.block(directions: .south) }
        (0..<avenues).forEach {
            coordinate[$0][0].block(directions: .west)
            coordinate[$0][streets-1].block(directions: .east)
        }
        // Additional walls
    }

    // MARK: Operate Karel
    func moveKarel(speed: Int) throws {
        
    }
}
