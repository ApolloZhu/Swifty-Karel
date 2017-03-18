import UIKit

class AZStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        reloadData()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        reloadData()
    }

    func setup() {
        distribution = .equalCentering
        alignment = .center
    }

    func reloadData() { }
}
