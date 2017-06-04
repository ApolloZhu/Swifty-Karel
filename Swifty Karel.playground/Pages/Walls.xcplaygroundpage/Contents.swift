/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Walls Blocks My Way
 When you are blocked by a wall, turn away from it!
 */
WorldModel(streets: 2, avenues: 2).makeKarel(at: Corner(2,1), facing: .west).addWall(from: .origin, to: Point(0,1)).addWall(from: .origin, to: Point(1,0)).setColor(.tianyi, for: Corner(2,1))
Playground.current.show(worldModel: WorldModel(streets: 2, avenues: 2).makeKarel(at: Point(1,2), facing: .east).addWall(from: .origin, to: Point(0,1)).addWall(from: .origin, to: Point(1,0)).setColor(.tianyi, for: Corner(2,1)))
//: - Experiment: Try to move Karel to the blue block, as shown above.

turnLeft()
move()

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
