import PlaygroundSupport
import UIKit

public enum SpeedConfig: RawRepresentable {
    case half
    case normal
    case double
    case quadruple
    case custom(scale: Double)

    public typealias RawValue = Double
    public init?(rawValue: Double) {
        switch rawValue {
        case 0.5: self = .half
        case 1: self = .normal
        case 2: self = .double
        case 4: self = .quadruple
        default: self = .custom(scale: rawValue)
        }
    }
    public var rawValue: Double {
        switch self {
        case .half: return 0.5
        case .normal: return 1
        case .double: return 2
        case .quadruple: return 4
        case .custom(let scale): return scale
        }
    }
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
                show(worldModel: clonedWorldModel(bgColor: oldValue.cornerBackgroundColor))
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

    public func saveAsImage(withName name: String) -> CachedViewable? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(worldView.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            worldView.layer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext(),
                let png = UIImagePNGRepresentation(image) {
                do {
                    let url = URL(fileURLWithPath: "\(name).png")
                    try png.write(to: url)
                    return CachedViewable(content: UIImageView(image: image), path: url.path)
                } catch { }
            }
        }
        return nil
    }

    func clonedWorldModel(bgColor: UIColor = Playground.current.colorScheme.cornerBackgroundColor) -> WorldModel {
        let model = worldView.worldModel.copy()
        model.makeKarel(at: Karel.current.position, facing: Karel.current.facing)
        worldView.corners.forEach {
            $0.forEach {
                if let color = $0.backgroundColor, color != bgColor {
                    model.setColor(color, for: $0.point)
                }
                if $0.beeperCount > 0 {
                    model.setBeeperCount(for: $0.point, to: $0.beeperCount)
                }

            }
        }
        return model
    }

    public func saveAsWorldModel(withName name: String) -> CachedViewable? {
        return clonedWorldModel().save(withName: name)
    }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}
