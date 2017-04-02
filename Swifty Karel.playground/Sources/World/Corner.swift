import UIKit

public class Corner: UIView, Coordinated {
    private var beeperView = BeeperView()
    var street, avenue: Int
    public private(set) var blocked: [GeologicalDirection]?

    public var borderColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }

    public var borderWidth: CGFloat {
        didSet {
            setNeedsLayout()
        }
    }

    public init(street: Int, avenue: Int, frame: CGRect, backgroundColor: UIColor? = .white, blockedInDirections directions: [GeologicalDirection]? = nil) {
        self.street = street
        self.avenue = avenue
        borderColor = .black
        borderWidth = 3
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        blocked = directions
    }

    convenience public init(_ point: Point, frame: CGRect, backgroundColor: UIColor? = .white, blockedInDirections directions: [GeologicalDirection]? = nil) {
        self.init(street:point.x,avenue:point.y, frame: frame, backgroundColor: backgroundColor, blockedInDirections: directions)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var beeperCount: Int {
        return Int(beeperView.beeperCount)
    }

    public func pickBeeper() throws {
        if beeperView.beeperCount == 0 {
            throw KarelError.noBeeper
        }
        beeperView.beeperCount -= 1
    }

    public func putBeeper() {
        beeperView.beeperCount += 1
    }

    public func block(directions: GeologicalDirection...) {
        if blocked != nil {
            blocked!.append(contentsOf: directions)
        } else {
            blocked = directions
        }
        setNeedsDisplay()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let blocked = blocked else { return }
        let path = UIBezierPath()
        for direction in blocked {
            switch direction {
            case .north:
                path.move(to: bounds.origin)
                path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            case .east:
                path.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
                path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            case .south:
                path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
                path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            case .west:
                path.move(to: bounds.origin)
                path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            }
        }
        path.lineWidth = borderWidth
        borderColor.setStroke()
        path.stroke()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showCoordinate(autoHide: true)
    }
}
