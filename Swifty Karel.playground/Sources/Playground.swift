import PlaygroundSupport

enum SpeedConfig: Double {
    case half   = 0.5
    case normal = 1
    case double = 2
    case tetral = 4
}

class Playground {
    public static let current = Playground()
    private init() { }

    func showError(_ error: Error) {

    }

    var speed: SpeedConfig = .normal
    var world: World? {
        didSet {

        }
    }
}
