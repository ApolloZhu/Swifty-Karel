import UIKit

class BeeperView: UIView {
    var beeperCount: UInt = 0 { didSet { setNeedsDisplay() } }
    private(set) lazy var beeperLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.frame = self.bounds
        label.textAlignment = .center
        return label
    }()
    var stroke: UIColor = .background { didSet { setNeedsDisplay(); beeperLabel.textColor = stroke } }
    var lineWidth: CGFloat = 5 { didSet { setNeedsDisplay() } }
    var fill: UIColor = .tianyi { didSet { setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if beeperCount > 0 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX, y: bounds.minY + lineWidth))
            path.addLine(to: CGPoint(x: bounds.minX + lineWidth, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - lineWidth))
            path.addLine(to: CGPoint(x: bounds.maxX - lineWidth, y: bounds.midY))
            path.close()
            stroke.setStroke()
            fill.setFill()
            path.lineWidth = lineWidth
            path.lineJoinStyle = .round
            path.lineCapStyle = .round
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
