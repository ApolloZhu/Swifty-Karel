import UIKit

class WorldView: UIView {
    static var current: WorldView {
        return Playground.current.worldView
    }
    var karelView: Karel
    let streets, avenues: Int
    let worldModel: WorldModel
    private let blockSize: CGFloat
    
    public init() {
        streets = 0
        avenues = 0
        worldModel = .invalid
        blockSize = 0
        karelView = Karel()
        super.init(frame: .zero)
        karelView.worldView = self
    }

    /// Must call `layout` by the client for some reason I don't know
    public init(model: WorldModel, in rect: CGRect) {
        karelView = Karel()
        worldModel = model
        streets = model.streetsCount
        avenues = model.avenuesCount
        let (frame, cornerSize) = rect.max(ratio: Point(avenues,streets))
        blockSize = cornerSize
        super.init(frame: frame)
        karelView.worldView = self
        karelView.position = worldModel.karelModel.point
        karelView.setFacing(worldModel.karelModel.facing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func realCorner(from point: Point) -> Point {
        return Point(point.y - 1, streets - point.x)
    }
    
    var corners = [[CornerView]]()
    
    func layout() {
        guard worldModel !== WorldModel.invalid else { return }
        corners = (1...streets).lazy.map { street in
            (1...avenues).lazy.map { avenue in
                let c = CornerView(street: street, avenue: avenue,
                               frame: CGRect(origin: realCorner(from: Point(street, avenue)).cgPoint(scaledBy: blockSize),
                                             size: CGSize(side: blockSize)))
                addSubview(c)
                return c
            }
        }

        karelView.frame = CGRect(origin: realCorner(from: karel.position).cgPoint(scaledBy: blockSize),
                                 size: CGSize(side: blockSize))
        addSubview(karelView)
        karelView.image = Playground.current.karelImage

        for beeper in worldModel.beepers.lazy {
            for _ in 0..<beeper.count {
                corners[beeper.corner.x-1][beeper.corner.y-1].putBeeper()
            }
        }
        for colored in worldModel.colored.lazy {
            corners[colored.corner.x-1][colored.corner.y-1].backgroundColor = colored.color
        }
        setWalls()
    }
    
    private func setWalls() {
        corners[0].forEach { $0.block(directions: .south) }
        corners[streets-1].forEach { $0.block(directions: .north) }
        (0..<streets).forEach {
            corners[$0][0].block(directions: .west)
            corners[$0][avenues-1].block(directions: .east)
        }
        
        for wall in worldModel.walls {
            if wall.start.x == wall.end.x {
                for y in wall.start.y ..< wall.end.y {
                    if wall.start.x > 0 {
                        corners[wall.start.x-1][y].block(directions: .north)
                    }
                    if wall.start.x < streets {
                        corners[wall.start.x][y].block(directions: .south)
                    }
                }
            } else {
                for x in wall.start.x ..< wall.end.x {
                    if wall.start.y > 0 {
                        corners[x][wall.start.y-1].block(directions: .east)
                    }
                    if wall.start.y < avenues {
                        corners[x][wall.start.y].block(directions: .west)
                    }
                }
            }
        }
        reload()
    }
    
    func reload() {
        corners.lazy.forEach {
            $0.lazy.forEach {
                if Playground.current.showCoordinates {
                    $0.showCoordinates()
                }
                $0.setNeedsDisplay()
            }
        }
    }
}

