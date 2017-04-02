import UIKit

public class Corner: UIView, Coordinated {
    private var beeperView = BeeperView()
    var point: Point
    var street: Int { return point.x }
    var avenue: Int { return point.y }
    public private(set) var blocked: [GeologicalDirection]?
    
    public convenience init(street: Int, avenue: Int, frame: CGRect, backgroundColor: UIColor = Playground.current.colorScheme.cornerBackgroundColor, blockedInDirections directions: [GeologicalDirection]? = nil) {
        self.init(point:Point(street,avenue), frame: frame, backgroundColor: backgroundColor, blockedInDirections: directions)
    }
    
    public init(point: Point, frame: CGRect, backgroundColor: UIColor = Playground.current.colorScheme.cornerBackgroundColor, blockedInDirections directions: [GeologicalDirection]? = nil) {
        self.point = point
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        layer.borderColor = UIColor.background.cgColor
        layer.borderWidth = 1
        blocked = directions
        beeperView.frame = bounds
        beeperView.backgroundColor = .clear
        addSubview(beeperView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var beeperCount: Int {
        return Int(beeperView.beeperCount)
    }
    
    public func pickBeeper() throws {
        if beeperView.beeperCount == 0 {
            throw KarelError.noBeeper(at: point)
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
        path.lineWidth = 5
        Playground.current.colorScheme.wallColor.setStroke()
        path.stroke()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showCoordinates(autoHide: true)
    }
}
