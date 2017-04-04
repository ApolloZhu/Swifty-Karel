//: [Previous](@previous)
import UIKit
/*:
 # Themes
 By default, Karel will decide the color settings for the world, according to the current system time. That is `.default` when bright, and `.dusk` when dim.
 */
/*:
 ## Customized Theme
 You can create a new `ColorScheme`, and tell Karel what color should things be in.
 */
let myTheme = ColorScheme(
    simulatorBackgroundColor: #colorLiteral(red: 0.1, green: 0.1, blue: 0.1, alpha: 1),
    cornerBackgroundColor: .black,
    cornerCoordinatesColor: #colorLiteral(red: 0.14, green: 1, blue: 0.51, alpha: 1),
    wallColor: #colorLiteral(red: 0.89, green: 0.49, blue: 0.28, alpha: 1),
    beeperBorderColor: #colorLiteral(red: 0, green: 0.63, blue: 1, alpha: 1),
    beeperFillColor: .background,
    beeperCountColor: .black
)
/*:
 By setting the `colorScheme`, you can decide which theme you want.
 - Experiment: Now, let's try out our new theme!
 */
Playground.current.colorScheme = myTheme
runKarel()
//: [Next](@next)
