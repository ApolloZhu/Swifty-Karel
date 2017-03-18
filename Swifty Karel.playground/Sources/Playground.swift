import PlaygroundSupport

enum SpeedConfig: Double {
    case half   = 0.5
    case normal = 1
    case double = 2
    case quadruple = 4
}

public class Playground {
    public static let current = Playground()

    let worldView = WorldView()

    private init() {
        PlaygroundPage.current.liveView = worldView
    }

    func showError(_ error: Error) {
        
    }

    var speed: SpeedConfig = .normal
    var world: World? {
        didSet {
            worldView.reloadData()
        }
    }
}
