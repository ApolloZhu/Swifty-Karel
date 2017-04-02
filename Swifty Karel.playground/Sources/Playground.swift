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
    public var page: PlaygroundPage { return .current }
    private init() {
        PlaygroundPage.current.liveView = viewController
        liveView.contentMode = .scaleAspectFit
        liveView.backgroundColor = .background
    }
    public var liveView: UIView {
        return viewController.view
    }
    public var karelImage = UIImage(named: "karel.png") {
        didSet {
            Karel.current.image = karelImage
        }
    }

    var worldView = WorldView()
    private let viewController = UIViewController()

    public func show(worldModel: WorldModel) {
        worldView = WorldView(model: worldModel, in: liveView.frame)
        worldView.layout()
        Karel.current.image = karelImage
        liveView.addSubview(worldView)
    }

    func showInfo(_ info: String) {
        //FIXME: Elegant info
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(side: 100)))
        label.text = info
        label.textColor = .white
        viewController.view.addSubview(label)
    }

    func showError(_ error: Error) {
        //FIXME: Elegant error
        showInfo(error.localizedDescription)
    }

    public var speed: SpeedConfig = .double
    var duration: Double { return 1/speed.rawValue }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}
