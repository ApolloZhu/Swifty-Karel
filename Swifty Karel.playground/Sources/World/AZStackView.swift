import UIKit

public class AZStackView: UIStackView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        distribution = .equalCentering
        alignment = .center
    }

    func reloadData() {
        //TODO: Reload Data
    }
}
