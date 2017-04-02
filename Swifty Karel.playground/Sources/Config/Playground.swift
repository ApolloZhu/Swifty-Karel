import PlaygroundSupport
import UIKit

public class Playground {
    public static let current = Playground()
    static let identifier = 6927
    public var page: PlaygroundPage { return .current }
    private init() {
        if let hour = Calendar.current.dateComponents([.hour], from: Date()).hour,
            hour > 19 || hour < 7 {
            colorScheme = .dusk
        } else {
            colorScheme = .default
        }
        PlaygroundPage.current.liveView = viewController
        liveView.backgroundColor = ColorScheme.default.simulatorBackgroundColor
        liveView.addSubview(HUD.shared.bar)
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
            HUD.shared.bar.backgroundColor = colorScheme.hudStyle.rawValue
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
        worldView.removeFromSuperview()
        liveView.backgroundColor = colorScheme.simulatorBackgroundColor
        worldView = WorldView(model: worldModel, in: liveView.frame)
        worldView.layout()
        Karel.current.image = karelImage
        liveView.addSubview(worldView)
    }

    public var speed: SpeedConfig = .double {
        didSet {
            HUD.shared.speedLabel.text = "\(speed.rawValue)x"
        }
    }
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

    public var isSoundEnabled = true {
        didSet {
            HUD.shared.soundButton.update()
        }
    }

    public var isMusicEnabled = true {
        didSet {
            HUD.shared.musicButton.update()
        }
    }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}
