import PlaygroundSupport
import UIKit
import AVFoundation

public class Playground {
    /// The current/only playground instance
    public static let current = Playground()
    static let identifier = 6927

    /// Current playground page
    public var page: PlaygroundPage { return .current }
    private let viewController = UIViewController()
    var liveView: UIView {
        return viewController.view
    }

    private init() {
        if let hour = Calendar.current.dateComponents([.hour], from: Date()).hour,
            hour > 19 || hour < 7 {
            colorScheme = .dusk
        } else {
            colorScheme = .default
        }
        PlaygroundPage.current.liveView = viewController
        liveView.backgroundColor = ColorScheme.default.simulatorBackgroundColor
    }

    /// Image of karel
    public var karelImage = UIImage(named: "Karel.png") {
        didSet {
            karel.image = karelImage
        }
    }

    /// Current color configuration for visuals. By default, it is dusk after eve, otherwise is default color scheme.
    public var colorScheme: ColorScheme {
        didSet {
            if worldView.worldModel !== WorldModel.invalid {
                show(worldModel: clonedWorldModel(bgColor: oldValue.cornerBackgroundColor))
            }
        }
    }

    var worldView = WorldView()
    var worldModel = WorldModel.invalid
    /// Load world model to playground
    ///
    /// - Parameter worldModel: world model to load
    public func show(worldModel: WorldModel) {
        worldView.removeFromSuperview()
        liveView.backgroundColor = colorScheme.simulatorBackgroundColor
        worldView = WorldView(model: worldModel, in: liveView.frame)
        worldView.layout()
        liveView.addSubview(worldView)
        backgroundMusicPlayer?.volume = backgroundMusicVolume
        if isBackgroundMusicEnabled {
            backgroundMusicPlayer?.play()
        }
    }

    /// If coordinates are shown in each corner
    public var showCoordinates = false {
        didSet {
            worldView.reload()
        }
    }

    /// Speed at which karel runs
    public var speed: SpeedConfig = .double
    var duration: Double { return 1/speed.rawValue }

    /// Save current world as image.
    ///
    /// - Parameter name: name of the image.
    /// - Returns: nil if failed; otherwise returns the image and its path.
    public func saveAsImage(withName name: String) -> CachedViewable? {
        if let image = worldView.snapshot(),
            let png = UIImagePNGRepresentation(image) {
            do {
                let url = URL(fileURLWithPath: "\(name).png")
                try png.write(to: url)
                return CachedViewable(content: UIImageView(image: image), path: url.path)
            } catch { }
        }
        return nil
    }

    func clonedWorldModel(bgColor: UIColor = Playground.current.colorScheme.cornerBackgroundColor) -> WorldModel {
        let model = worldView.worldModel.copy()
        model.makeKarel(at: karel.position, facing: karel.facing)
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

    /// Save current world as world model.
    ///
    /// - Parameter name: name of the world model.
    /// - Returns: nil if failed to save, otherwise returns the saved world model and its path.
    public func saveAsWorldModel(withName name: String) -> CachedViewable? {
        return clonedWorldModel().save(withName: name)
    }

    lazy private var backgroundMusicPlayer: AVAudioPlayer? = {
        do {
            let player = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "Background", withExtension: "mp3")!)
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.volume = 0.7
            return player
        } catch {
            karel.alert("Can not locate background music file")
            return nil
        }
    }()

    /// If background music should play
    public var isBackgroundMusicEnabled = true {
        willSet {
            if newValue {
                backgroundMusicPlayer?.play()
            } else {
                backgroundMusicPlayer?.pause()
            }
        }
    }

    /// The volume of the background music
    public var backgroundMusicVolume: Float = 1 {
        willSet {
            backgroundMusicPlayer?.volume = newValue
        }
    }

    /// If Karel completes its task dynamicly or not
    public var isAnimationEnabled: Bool = true
}
