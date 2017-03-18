import UIKit

class WorldView: AZStackView {
    override func setup() {
        super.setup()
        axis = .vertical
    }

    var streets: Int {
        get { return World.current?.streets ?? 3 }
        set { World.current?.streets = newValue }
    }

    var avenues: Int {
        get { return World.current?.avenues ?? 3 }
        set { World.current?.avenues = newValue }
    }

    var karelView = Karel()

    override func reloadData() {

    }
}

