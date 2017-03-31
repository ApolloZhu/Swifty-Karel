import UIKit

public class World: AZStackView {
    public static var current: World {
        return Playground.current.worldView
    }

    override public func setup() {
        super.setup()
        axis = .vertical
        addSubview(karelView)
    }

    var streets = 3, avenues = 3

    public var karelView = Karel()

    func reloadData() {
        //TODO: Reload Data
    }

    var corners = [[Corner]]()

//    init(settings: [String:Any]) {
//        self.karel = Karel()
//        self.streets = 1;
//        self.avenues = 2;
//
//        for street in 1...streets {
//            var row = [Corner]()
//            for avenue in 1...avenues {
//                row.append(Corner(street: street, avenue: avenue))
//            }
//            coordinate.append(row)
//        }
//        setWalls()
//    }

    func setWalls(_ walls: [Int] = [Int]()) {
        // Around the world
        corners[0].forEach { $0.block(directions: .north) }
        corners[avenues-1].forEach { $0.block(directions: .south) }
        (0..<avenues).forEach {
            corners[$0][0].block(directions: .west)
            corners[$0][streets-1].block(directions: .east)
        }
        // Additional walls
    }
}

