import UIKit

public class Karel: UIView, Coordinated {
    
    // MARK: Setup
    class var current: Karel {
        return Playground.current.worldView.karelView
    }
    
    private var imageView = UIImageView()
    var image = UIImage(named: "Karel.png") {
        didSet {
            imageView.removeFromSuperview()
            imageView.frame = bounds
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
        }
    }
    
    // MARK: Animation
    private var count = 0.0
    fileprivate func animate(animatable: Bool = true, by animation: @escaping (Karel) -> Void) {
        count += 1
        if animatable {
            UIView.animate(withDuration: Playground.current.duration, delay: Playground.current.duration * count, options: .curveEaseInOut, animations: { [weak self] in
                if let this = self {
                    Playground.current.liveView.subviews.lazy.forEach {
                        if $0.tag == Playground.identifier {
                            $0.removeFromSuperview()
                        }
                    }
                    if animatable {
                        animation(this)
                    }
                }}
            )
        } else {
            let timer = Timer.scheduledTimer(withTimeInterval: Playground.current.duration * count, repeats: false) { [weak self] timer in
                defer { timer.invalidate() }
                guard let this = self else { return }
                Playground.current.liveView.subviews.lazy.forEach {
                    if $0.tag == Playground.identifier {
                        $0.removeFromSuperview()
                    }
                }
                animation(this)
            }
        }
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
        return WorldView.current.corners[street-1][avenue-1]
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
                return KarelError.beenBlocked(at: this.position, facing: this.facing).show()
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
        let corner = self.corner
        animate(animatable: false) { _ in
            for _ in 0..<count {
                do {
                    try corner.pickBeeper()
                } catch {
                    error.show()
                }
            }
        }
    }
    
    func putBeeper(count: Int = 1) {
        let corner = self.corner
        animate(animatable: false) { _ in
            for _ in 0..<count {
                corner.putBeeper()
            }
        }
    }
    
    var colorOfBlock: UIColor {
        return corner.backgroundColor ?? Playground.current.colorScheme.cornerBackgroundColor
    }
    
    func paintBlock(color: UIColor) {
        let corner = self.corner
        animate(animatable: false) { _ in
            corner.backgroundColor = color
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

extension Karel {
    public func alert(_ info: String) {
        let liveView = Playground.current.liveView
        let frame = CGRect(origin: liveView.center, size: .zero)
        
        let cover = UIView(frame: frame)
        cover.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        cover.tag = Playground.identifier
        
        let label = UILabel(frame: frame)
        label.tag = Playground.identifier
        label.text = info
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .background
        label.alpha = 0.9
        animate { _ in
            liveView.addSubview(cover)
            liveView.addSubview(label)
            cover.frame = liveView.bounds
            label.frame = liveView.bounds.max(ratio: Point(16,9), insect: UIEdgeInsets(side: 20)).frame
        }
    }
}

extension Error {
    func show() {
        Karel.current.alert(self.localizedDescription)
    }
}

enum KarelError: Error, LocalizedError {
    case beenBlocked(at: Point, facing: GeologicalDirection)
    case noBeeper(at: Point)
    var errorDescription: String? {
        switch self {
        case .noBeeper(let point):
            return "Karel is trying to pick up nothing at \(point)"
        case .beenBlocked(let point, facing):
            return "Karel is blocked at \(point), facing \(facing)"
        default:
            return "Karel %^$#*#^$&!"
        }
    }
}




