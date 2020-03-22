/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Customize your playground
 Playground is highly customizable, let's walk through some settings you can configure.
 */
/*:
 ## Coordinate System
 By setting `showCoordinates` to `true`, each corner will display its coordinates
 */
Playground.current.showCoordinates = true
/*:
 ## Karel
 You can set Karel to the image you like
 */
Playground.current.karelImage = #imageLiteral(resourceName: "Origin.png")
/*:
 You can control the speed of Karel. Built-in settings include
 
 - `.normal`, the default option
 - `.half`
 - `.double`
 - `.quadruple`

 If they can't fit your needs, you can always decide it yourself.

 - Experiment:  Make Karel run 3 times as fast as normal
 */
Playground.current.speed = .custom(scale: 3)
//: If you don't like the background music that is going on, you can turn it off!
Playground.current.isBackgroundMusicEnabled = false
//: Alternatively, you may lower the volume of the music.
Playground.current.isBackgroundMusicEnabled = true
Playground.current.backgroundMusicVolume = 0.3
//: Let's see what have changed!
runKarel()
/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
