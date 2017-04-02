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

    public func saveAsImage(withName name: String) -> CachedImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(worldView.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            worldView.layer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext(),
                let png = UIImagePNGRepresentation(image) {
                do {
                    let url = URL(fileURLWithPath: "\(name).png")
                    try png.write(to: url)
                    return CachedImage(image: image, path: url.path)
                } catch { }
            }
        }
        return nil
    }
}

public struct CachedImage {
    public let image: UIImage
    public let path: String
}

extension CachedImage: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        let view = UIView(frame: CGRect(origin: .zero, size: image.size))
        view.backgroundColor = .background
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY, width: imageView.bounds.width, height: 50))
        label.text = path
        label.numberOfLines = 0
        label.sizeToFit()
        view.frame.size.height += label.frame.height
        view.addSubview(label)
        return .view(view)
    }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}
