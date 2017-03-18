import UIKit

public class Karel: UIImageView {
    public class var current: Karel? {
        return Playground.current.world?.karel
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
        //        isOpaque = false
    }

    public func move() {

    }

    public func turnLeft() {

    }

    public func pickBeeper() {

    }

    public func putBeeper() {

    }

    // MARK: World Related
    public var position: Point?

    public var facing: MapDirection?

    public var isOnBeeper: Bool {
        return true
    }

    public var isBlocked: Bool {
        return true
    }

    public func isClear(at direction: Direction) -> Bool {
        return true
    }

    public func turnRight() {

    }

    public func turnAround() {

    }

    public func pickBepper(count: Int) {

    }

    public func putBeeper(count: Int) {

    }

    public func paintBlock(color: UIColor) {
        if let world = World.current, let x = position?.x, let y = position?.y {
            world.coordinate[x][y].backgroundColor = color
        }
    }

    public var colorOfBlock: UIColor {
        return .clear
    }
}

extension Karel {
    public func isBlocked(at direction: Direction) -> Bool {
        return !isClear(at: direction)
    }

    public func isFacing(_ direction: MapDirection) -> Bool {
        return self.facing == direction
    }
    
    public func isNotFacing(_ direction: MapDirection) -> Bool {
        return !isFacing(direction)
    }
}
