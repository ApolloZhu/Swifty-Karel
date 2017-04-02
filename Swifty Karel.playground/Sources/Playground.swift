import PlaygroundSupport
import UIKit

public enum SpeedConfig: Double {
    case half   = 0.5
    case normal = 1
    case double = 2
    case quadruple = 4
}

public class Playground {
    public static let current = Playground()
    static let identifier = 6927
    public var page: PlaygroundPage { return .current }
    private init() {
        if let hour = Calendar.current.dateComponents([.hour], from: Date()).hour,
            hour > 19 || hour < 7 {
            colorScheme = .dusk
        } else {
            colorScheme = .`default`
        }
        PlaygroundPage.current.liveView = viewController
        liveView.backgroundColor = ColorScheme.`default`.simulatorBackgroundColor
    }
    var liveView: UIView {
        return viewController.view
    }
    public var karelImage = UIImage(named: "Karel.png") {
        didSet {
            Karel.current.image = karelImage
        }
    }
    public var colorScheme: ColorScheme {
        didSet {
            if worldView.worldModel !== WorldModel.invalid {
                show(worldModel: worldView.worldModel)
            }
        }
    }
    public var showCoordinates = false {
        didSet {
            worldView.reload()
        }
    }

    var worldView = WorldView()
    private let viewController = UIViewController()

    public func show(worldModel: WorldModel) {
        liveView.backgroundColor = colorScheme.simulatorBackgroundColor
        worldView = WorldView(model: worldModel, in: liveView.frame)
        worldView.layout()
        Karel.current.image = karelImage
        liveView.addSubview(worldView)
    }

    public var speed: SpeedConfig = .double
    var duration: Double { return 1/speed.rawValue }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}
