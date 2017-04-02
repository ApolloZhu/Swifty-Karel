import PlaygroundSupport
import UIKit
import AVFoundation

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
        worldView.removeFromSuperview()
        liveView.backgroundColor = colorScheme.simulatorBackgroundColor
        worldView = WorldView(model: worldModel, in: liveView.frame)
        worldView.layout()
        Karel.current.image = karelImage
        liveView.addSubview(worldView)
        if isMusicEnabled {
            backgroundMusicPlayer?.play()
        }
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
    lazy var backgroundMusicPlayer: AVAudioPlayer? = {
        do {
            let player = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "Background", withExtension: "mp3")!)
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.volume = 0.7
            return player
        } catch {
            Karel.current.alert("Can not locate background music file")
            return nil
        }
    }()
    
    public var isMusicEnabled = true {
        didSet {
            if isMusicEnabled {
                backgroundMusicPlayer?.play()
            } else {
                backgroundMusicPlayer?.pause()
            }
        }
    }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}
