import UIKit

public enum HUDStyle: RawRepresentable, CustomStringConvertible {
    case light(background: UIColor), dark(background: UIColor)

    public typealias RawValue = UIColor
    public init?(rawValue: UIColor) {
        var white: CGFloat = 0
        rawValue.getWhite(&white, alpha: nil)
        if white > 0.5 {
            self = .light(background: rawValue)
        } else {
            self = .dark(background: rawValue)
        }
    }
    public var rawValue: UIColor {
        switch self {
        case .light(let background):
            return background
        case .dark(let background):
            return background
        }
    }

    public var description: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}

enum AssetsType: CustomStringConvertible {
    case music, sound, no
    var description: String {
        switch self {
        case .music: return "Music"
        case .sound: return "Sound"
        case .no: return "No"
        }
    }
    var image: UIImage? {
        return UIImage(named: "\(self)_\(Playground.current.colorScheme.hudStyle).png")
    }
}

class HUD {
    static let shared = HUD()
    let bar = UIToolbar()
    let soundButton = SwitchableContainer(type: .sound)
    let musicButton = SwitchableContainer(type: .music)
    let speedLabel: UILabel  = {
        let label = UILabel()
        label.text = "\(Playground.current.speed.rawValue)x"
        return label
    }()
    init() {
        bar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: soundButton.button),
            UIBarButtonItem(customView: musicButton.button),
            UIBarButtonItem(customView: speedLabel)
            ], animated: true)
        bar.backgroundColor = Playground.current.colorScheme.hudStyle.rawValue
    }
}

class SwitchableContainer {
    let button = UIButton()
    let type: AssetsType
    init(type: AssetsType) {
        self.type = type
        button.setBackgroundImage(type.image, for: .normal)
        button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }

    @objc private func toggle() {
        switch type {
        case .music: Playground.current.isMusicEnabled.toggle()
        case .sound: Playground.current.isSoundEnabled.toggle()
        default: return
        }
    }

    func update() {
        var isOn = true
        switch type {
        case .music: isOn = Playground.current.isMusicEnabled
        case .sound: isOn = Playground.current.isSoundEnabled
        default: return
        }
        if isOn {
            button.setImage(nil, for: .normal)
        } else {
            button.setImage(AssetsType.no.image, for: .normal)
        }
    }
}

extension Bool {
    @discardableResult
    mutating func toggle() -> Bool {
        self = !self
        return self
    }
}
