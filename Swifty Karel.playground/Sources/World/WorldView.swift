import UIKit

class WorldView: UIView {
    public var karelView = Karel()
    public let streets, avenues: Int
    public let worldModel: WorldModel
    private let blockSize: CGFloat

    private static func maxRect(in rect: CGRect, street: Int, avenue: Int, insect: UIEdgeInsets = .zero) -> (frame: CGRect, side: CGFloat) {
        let w = rect.width - insect.left - insect.right
        let h = rect.height - insect.top - insect.bottom
        let c_x = CGFloat(street)
        let c_y = CGFloat(avenue)
        let side = min(w/c_x,h/c_y)
        let aW = side * c_x
        let aH = side * c_y
        return (CGRect(x: rect.midX - aW/2, y: rect.midY - aH/2, width: aW, height: aH), side)
    }

    public init(model: WorldModel, in rect: CGRect) {
        worldModel = model
        streets = model.streetsCount
        avenues = model.avenuesCount
        let (frame, cornerSize) = WorldView.maxRect(in: rect, street: streets, avenue: avenues)
        blockSize = cornerSize
        super.init(frame: frame)
        contentMode = .scaleAspectFit
        karelView.position = worldModel.karel.point
        karelView.facing = worldModel.karel.facing
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func realCorner(from point: Point) -> Point {
        return point
//        return Point(streets - point.x,point.y - 1)
    }

    var corners = [[Corner]]()

    func layout() {
        karelView.frame = CGRect(origin: realCorner(from: karel.position).cgPoint(scaledBy: blockSize),
                                 size: CGSize(side: blockSize))

        corners = (1...streets).lazy.map { street in
            (1...avenues).lazy.map { avenue in
                let c = Corner(street: street, avenue: avenue,
                               frame: CGRect(origin: realCorner(from: Point(street, avenue)).cgPoint(scaledBy: blockSize),
                                             size: CGSize(side: blockSize)))
                addSubview(c)
                return c
            }
        }
        setWalls()
        addSubview(karelView)
    }

    func setWalls() {
        // Around the world
        corners[0].forEach { $0.block(directions: .south) }
        corners[streets-1].forEach { $0.block(directions: .north) }
        (0..<avenues).forEach {
            corners[0][$0].block(directions: .west)
            corners[streets-1][$0].block(directions: .east)
        }
        // Additional walls
        for wall in worldModel.walls {
            if wall.start.x == wall.end.x {
                for y in wall.start.y ..< wall.end.y {
                    if wall.start.x > 0 {
                        corners[wall.start.x-1][y].block(directions: .east)
                    }
                    if wall.start.x < streets {
                        corners[wall.start.x][y].block(directions: .west)
                    }
                }
            } else {
                for x in wall.start.x ..< wall.end.x {
                    if wall.start.y > 0 {
                        corners[x][wall.start.y-1].block(directions: .north)
                    }
                    if wall.start.y < avenues {
                        corners[x][wall.start.y].block(directions: .south)
                    }
                }
            }
        }
        redraw()
    }

    private func redraw() {
        corners.forEach {
            $0.forEach {
                $0.setNeedsDisplay()
            }
        }
    }
}

