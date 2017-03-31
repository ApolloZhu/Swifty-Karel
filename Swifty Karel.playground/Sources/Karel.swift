import UIKit

public class Karel: UIImageView {
    // MARK: Setup
    public class var current: Karel {
        return Playground.current.worldView.karelView
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public init(image: UIImage?) {
        super.init(image: image)
        setup()
    }

    override public init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }

    private func setup() {
        image = UIImage(named: "karel")
        contentMode = .scaleAspectFit
        backgroundColor = .yellow
    }

    // MARK: Animation
    private var count = 0.0
    private func animate(by animation: @escaping (Karel) -> Void) {
        count += 1
        UIView.animate(withDuration: Playground.current.duration, delay: Playground.current.duration * count, options: .curveEaseInOut, animations:
            { [weak self] in
                if let this = self {
                    animation(this)
                }
            }, completion: { [weak self] _ in if let this = self { this.count -= 1 }})
    }

    // MARK: World
    public var position = Point.zero
    private var cornor: Corner {
        return World.current.corners[position.x][position.y]
    }
    public var facing = MapDirection.east

    // Mark: Features
    public var isBlocked: Bool {
        return cornor.blocked?.contains(facing) ?? false
    }

    public func isClear(at direction: Direction) -> Bool {
        return cornor.blocked?.contains(facing.mapDirection(whenFacing: direction)) != true
    }

    func move() {
        animate { this in
//            guard !this.isBlocked else {
//                // This also include situation which karel is at the edge
//                return KarelError.beenBlocked(at: this.position, facing: this.facing).show()
//            }
            switch this.facing {
            case .west:
                this.frame.origin.x -= this.frame.width
                this.position.x -= 1
            case .east:
                this.frame.origin.x += this.frame.width
                this.position.x += 1
            case .north:
                this.frame.origin.y -= this.frame.height
                this.position.y -= 1
            case .south:
                this.frame.origin.y += this.frame.height
                this.position.y += 1
            }
        }
    }

    func turnLeft() {
        animate { this in
            let transform = CGAffineTransform(rotationAngle: -.pi/2.0)
            this.layer.setAffineTransform(transform)
            this.facing.turnLeft()
        }
    }

    func turnRight() {
        animate { this in
            let transform = CGAffineTransform(rotationAngle: .pi/2.0)
            this.layer.setAffineTransform(transform)
            this.facing.turnRight()
        }
    }

    public func turnAround() {
        animate { this in
            let transform = CGAffineTransform(rotationAngle: .pi)
            this.layer.setAffineTransform(transform)
            this.facing.turnLeft()
            this.facing.turnLeft()
        }
    }

    public var isOnBeeper: Bool {
        return cornor.beeperCount > 0
    }

    public func pickBepper(count: Int = 1) {
        for _ in 0..<count {
            do {
                try cornor.pickBeeper()
            } catch {
                error.show()
            }
        }
    }

    public func putBeeper(count: Int = 1) {
        for _ in 0..<count {
            cornor.putBeeper()
        }
    }

    public var colorOfBlock: UIColor {
        return cornor.backgroundColor ?? .clear
    }

    public func paintBlock(color: UIColor) {
        cornor.backgroundColor = color
    }
}

extension Karel {
    public func isBlocked(at direction: Direction) -> Bool {
        return !isClear(at: direction)
    }

    public func isFacing(_ direction: MapDirection) -> Bool {
        return facing == direction
    }

    public func isNotFacing(_ direction: MapDirection) -> Bool {
        return !isFacing(direction)
    }
}
