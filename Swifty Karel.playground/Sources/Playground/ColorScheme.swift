import UIKit

public struct ColorScheme {
    public let simulatorBackgroundColor: UIColor
    public let cornerBackgroundColor: UIColor
    public let cornerCoordinatesColor: UIColor
    public let wallColor: UIColor
    public let beeperBorderColor: UIColor
    public let beeperFillColor: UIColor
    public let beeperCountColor: UIColor
    public init(simulatorBackgroundColor: UIColor, cornerBackgroundColor: UIColor, cornerCoordinatesColor: UIColor, wallColor: UIColor, beeperBorderColor: UIColor, beeperFillColor: UIColor, beeperCountColor: UIColor) {
        self.simulatorBackgroundColor = simulatorBackgroundColor
        self.cornerBackgroundColor = cornerBackgroundColor
        self.cornerCoordinatesColor = cornerCoordinatesColor
        self.wallColor = wallColor
        self.beeperBorderColor = beeperBorderColor
        self.beeperFillColor = beeperFillColor
        self.beeperCountColor = beeperCountColor
    }
}

extension ColorScheme {
    public static let `default` = ColorScheme(
        simulatorBackgroundColor: .background,
        cornerBackgroundColor: .white,
        cornerCoordinatesColor: .black,
        wallColor: .black,
        beeperBorderColor: .background,
        beeperFillColor: .tianyi,
        beeperCountColor: .black
    )

    public static let dusk = ColorScheme(
        simulatorBackgroundColor: #colorLiteral(red: 0.25, green: 0.25, blue: 0.29, alpha: 1),
        cornerBackgroundColor: #colorLiteral(red: 0.12, green: 0.13, blue: 0.16, alpha: 1),
        cornerCoordinatesColor: #colorLiteral(red: 0.86, green: 0.17, blue: 0.22, alpha: 1),
        wallColor: #colorLiteral(red: 0.51, green: 0.75, blue: 0.34, alpha: 1),
        beeperBorderColor: #colorLiteral(red: 0.51, green: 0.75, blue: 0.34, alpha: 1),
        beeperFillColor: .background,
        beeperCountColor: .black
    )
}
