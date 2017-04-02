import UIKit

public class Karel: UIView, Coordinated {

    // MARK: Setup
    class var current: Karel {
        return Playground.current.worldView.karelView
    }

    private var imageView = UIImageView()
    var image = UIImage(named: "karel.png") {
        didSet {
            imageView.removeFromSuperview()
            imageView.frame = bounds
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
            showCoordinate()
        }
    }

    // MARK: Animation
    private var count = 0.0
    private func animate(by animation: @escaping (Karel) -> Void) {
        count += 1
        UIView.animate(withDuration: Playground.current.duration, delay: Playground.current.duration * count, options: .curveEaseInOut, animations: { [weak self] in
            if let this = self {
                this.subviews.forEach {
                    if $0 is UILabel {
                        $0.removeFromSuperview()
                    }
                }
                animation(this)
                this.showCoordinate()
            }}
        )
    }

    // MARK: World
    var position = Point.zero
    var street: Int {
        get { return position.x }
        set { position.x = newValue }
    }
    var avenue: Int {
        get { return position.y }
        set { position.y = newValue }
    }

    private var corner: Corner {
        return Playground.current.worldView.corners[street-1][avenue-1]
    }
    private(set) var facing = GeologicalDirection.east
    func setFacing(_ newValue: GeologicalDirection) {
        while facing != newValue {
            turnLeft()
        }
    }

    // Mark: Features
    var isBlocked: Bool {
        return corner.blocked?.contains(facing) ?? false
    }

    func isClear(at direction: Direction) -> Bool {
        return corner.blocked?.contains(facing.geologicalDirection(whenFacing: direction)) != true
    }

    func move() {
        animate { this in
            guard !this.isBlocked else {
                // This also include situation which karel is at the edge
                fatalError(KarelError.beenBlocked(at: this.position, facing: this.facing).localizedDescription)
            }
            switch this.facing {
            case .west:
                this.frame.origin.x -= this.frame.width
                this.avenue -= 1

            case .east:
                this.frame.origin.x += this.frame.width
                this.avenue += 1

            case .north:
                this.frame.origin.y -= this.frame.height
                this.street += 1

            case .south:
                this.frame.origin.y += this.frame.height
                this.street -= 1

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
        facing.turnLeft()
        facing.turnLeft()
        animate { this in
            let transform = this.layer.affineTransform().rotated(by: .pi)
            this.layer.setAffineTransform(transform)
        }
    }

    var isOnBeeper: Bool {
        return corner.beeperCount > 0
    }

    func pickBepper(count: Int = 1) {
        for _ in 0..<count {
            do {
                try corner.pickBeeper()
            } catch {
                error.show()
            }
        }
    }

    func putBeeper(count: Int = 1) {
        for _ in 0..<count {
            corner.putBeeper()
        }
    }

    var colorOfBlock: UIColor {
        return corner.backgroundColor ?? .clear
    }

    func paintBlock(color: UIColor) {
        animate { this in
            this.corner.backgroundColor = color
        }
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
