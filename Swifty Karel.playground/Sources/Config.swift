import Foundation

public enum SpeedConfig: Double {
    case half   = 0.5
    case normal = 1
    case double = 2
    case tetral = 4
}

public class Config {
    public static let current = Config()
    private init() { }

    var speed: SpeedConfig = .normal
    var world: World? {
        didSet {

        }
    }
}
