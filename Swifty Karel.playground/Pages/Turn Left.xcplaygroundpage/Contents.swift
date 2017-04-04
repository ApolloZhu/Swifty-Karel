/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Turn Left
 When you are blocked by a wall, turn away from it!
 - Important: The `turnLeft()` method turns Karel to its left(counter-clockwise).
 */
WorldModel(streets: 2, avenues: 2).makeKarel(at: Point(1,2), facing: .north).addWall(from: .origin, to: Point(0,1)).addWall(from: .origin, to: Point(1,0))
Playground.current.show(worldModel: WorldModel(streets: 2, avenues: 2).makeKarel(at: Point(1,2), facing: .east).addWall(from: .origin, to: Point(0,1)).addWall(from: .origin, to: Point(1,0)))
//: - Experiment: Try to move karel turns to face up, like shown above.

turnLeft()
move()
turnLeft()
move()

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
