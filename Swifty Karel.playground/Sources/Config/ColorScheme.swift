import UIKit

public struct ColorScheme {
    public let simulatorBackgroundColor: UIColor
    public let cornerBackgroundColor: UIColor
    public let cornerCoordinatesColor: UIColor
    public let wallColor: UIColor
    public let beeperBorderColor: UIColor
    public let beeperFillColor: UIColor
    public let bepperCountColor: UIColor
}

extension ColorScheme {
    public static let `default` = ColorScheme(
        simulatorBackgroundColor: .background,
        cornerBackgroundColor: .white,
        cornerCoordinatesColor: .black,
        wallColor: .black,
        beeperBorderColor: .background,
        beeperFillColor: .tianyi,
        bepperCountColor: .black
    )
    
    public static let dusk = ColorScheme.init(
        simulatorBackgroundColor: UIColor(red: 0.25, green: 0.25, blue: 0.29, alpha: 1),
        cornerBackgroundColor: UIColor(red: 0.12, green: 0.13, blue: 0.16, alpha: 1),
        cornerCoordinatesColor: UIColor(red: 0.86, green: 0.17, blue: 0.22, alpha: 1),
        wallColor: UIColor(red: 0.51, green: 0.75, blue: 0.34, alpha: 1),
        beeperBorderColor: UIColor(red: 0.51, green: 0.75, blue: 0.34, alpha: 1),
        beeperFillColor: .background,
        bepperCountColor: .black
    )
}
