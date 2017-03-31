import UIKit

public class WorldView: AZStackView {
    public var karelView = Karel()

    public class func from(model: WorldModel) -> WorldView {
        let view = WorldView()
        view.worldModel = model

        return view
    }

    override public func setup() {
        super.setup()
        axis = .vertical
        addSubview(karelView)
    }

    var worldModel: WorldModel! = nil

    public private(set) var streets = 3 { didSet { reloadData() } }
    public private(set) var avenues = 3 { didSet { reloadData() } }
    private(set) var corners = [[Corner]]()

    override func reloadData() {
        for view in arrangedSubviews where view is AZStackView {
            let row = view as! AZStackView
            for corner in row.arrangedSubviews {
                row.removeArrangedSubview(corner)
                corner.removeFromSuperview()
            }
            removeArrangedSubview(row)
            row.removeFromSuperview()
        }
        corners = (1...streets).map { street in
            (1...avenues).map { avenue in
                Corner(street: street, avenue: avenue)
            }
        }
        setWalls()
    }

    func setWalls(_ walls: [Int] = []) {
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

