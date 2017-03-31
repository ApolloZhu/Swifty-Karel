import UIKit

class BeeperView: UIView {
    var beeperCount: UInt = 0 { didSet { setNeedsDisplay() } }
    private(set) lazy var beeperLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    var stroke: UIColor = .gray { didSet { setNeedsDisplay(); beeperLabel.textColor = stroke } }
    var lineWidth: CGFloat = 5 { didSet { setNeedsDisplay() } }
    var fill: UIColor = .tianyi { didSet { setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        beeperLabel.frame = bounds
        if beeperCount > 0 {
            let path = UIBezierPath()

            path.move(to: CGPoint(x: frame.midX, y: frame.minY))
            path.addLine(to: CGPoint(x: frame.minX, y: frame.midY))
            path.addLine(to: CGPoint(x: frame.midX, y: frame.maxY))
            path.close()

            stroke.setStroke()
            fill.setFill()
            path.lineWidth = lineWidth
            path.stroke()
            path.fill()
        }

        if beeperCount > 1 {
            beeperLabel.isHidden = false
            beeperLabel.text = "\(beeperCount)"
        } else {
            beeperLabel.isHidden = true
        }
    }
}
