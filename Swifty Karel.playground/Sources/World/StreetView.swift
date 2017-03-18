import UIKit

class StreetView: AZStackView {
    override func setup() {
        super.setup()
        axis = .horizontal
    }

    var avenues: Int {
        get { return World.current?.avenues ?? 3 }
        set { World.current?.avenues = newValue }
    }
}
