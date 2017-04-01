import UIKit

public class Karel: UIImageView {
    // MARK: Setup
    class var current: Karel {
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
        backgroundColor = .tianyi
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
    var position = Point.zero
    private var cornor: Corner {
        return Playground.current.worldView.corners[position.x][position.y]
    }
    var facing = GeologicalDirection.east

    // Mark: Features
    var isBlocked: Bool {
        return cornor.blocked?.contains(facing) ?? false
    }

    func isClear(at direction: Direction) -> Bool {
        return cornor.blocked?.contains(facing.geologicalDirection(whenFacing: direction)) != true
    }

    func move() {
        animate { this in
            //FIXME: Implement world first
            guard !this.isBlocked else {
                // This also include situation which karel is at the edge
                fatalError(KarelError.beenBlocked(at: this.position, facing: this.facing).localizedDescription)
            }
            switch this.facing {
            case .west:
                this.frame.origin.x -= this.frame.width
                this.position.x -= 1
            case .east:
                this.frame.origin.x += this.frame.width
                this.position.x += 1
            case .north:
                this.frame.origin.y -= this.frame.height
                this.position.y += 1
            case .south:
                this.frame.origin.y += this.frame.height
                this.position.y -= 1
            }
        }
    }

    func turnLeft() {
        animate { this in
            let transform = this.layer.affineTransform().rotated(by: -.pi/2.0)
            this.layer.setAffineTransform(transform)
            this.facing.turnLeft()
        }
    }

    func turnRight() {
        animate { this in
            let transform = this.layer.affineTransform().rotated(by: .pi/2.0)
            this.layer.setAffineTransform(transform)
            this.facing.turnRight()
        }
    }

    func turnAround() {
        animate { this in
            let transform = this.layer.affineTransform().rotated(by: .pi)
            this.layer.setAffineTransform(transform)
            this.facing.turnLeft()
            this.facing.turnLeft()
        }
    }

    var isOnBeeper: Bool {
        return cornor.beeperCount > 0
    }

    func pickBepper(count: Int = 1) {
        for _ in 0..<count {
            do {
                try cornor.pickBeeper()
            } catch {
                error.show()
            }
        }
    }

    func putBeeper(count: Int = 1) {
        for _ in 0..<count {
            cornor.putBeeper()
        }
    }

    var colorOfBlock: UIColor {
        return cornor.backgroundColor ?? .clear
    }

    func paintBlock(color: UIColor) {
        cornor.backgroundColor = color
    }
}

extension Karel {
    func isBlocked(at direction: Direction) -> Bool {
        return !isClear(at: direction)
    }

    func isFacing(_ direction: GeologicalDirection) -> Bool {
        return facing == direction
    }

    func isNotFacing(_ direction: GeologicalDirection) -> Bool {
        return !isFacing(direction)
    }
}
