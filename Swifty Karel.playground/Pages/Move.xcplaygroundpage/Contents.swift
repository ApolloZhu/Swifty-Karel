/*: 
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 - Important: The `move()` method moves karel one corner to the front.
 */
WorldModel(streets: 1, avenues: 3).makeKarel(at: Point(1,3), facing: .east)
Playground.current.show(worldModel: WorldModel(streets: 1, avenues: 3))
//: - Experiment: Try to move karel to the right, like shown above.

move()

/*:
  ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
