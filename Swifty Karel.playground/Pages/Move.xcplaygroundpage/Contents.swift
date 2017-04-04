/*: 
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Start Exploring!

 The world is wide and beautiful, Karel needs to see it all.

 - Important: The `move()` method moves karel one corner to the front.
 */
WorldModel(streets: 1, avenues: 3).makeKarel(at: Point(1,3), facing: .east)
Playground.current.show(worldModel: WorldModel(streets: 1, avenues: 3))
//: - Experiment: Try to move karel forward one more step!

move()

/*:
  ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
