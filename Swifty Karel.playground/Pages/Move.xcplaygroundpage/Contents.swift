/*: 
 [Previous](@previous) | [Next](@next)
 ****
 # Start Exploring!

 The world is wide and beautiful, Karel needs to see it all.

 - Important: The `move()` method moves Karel one corner to the front.
 */
WorldModel(streets: 1, avenues: 3).makeKarel(at: Point(1,3), facing: .east)
Playground.current.show(worldModel: WorldModel(streets: 1, avenues: 3))
//: - Experiment: Try to move Karel forward one more step!

move()

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
