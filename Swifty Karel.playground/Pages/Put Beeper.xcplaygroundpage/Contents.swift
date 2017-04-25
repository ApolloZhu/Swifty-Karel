/*:
[Previous](@previous) | [Next](@next)
 ****
 # Put Beepers
 Karel always carries a lot of beepers. 
 No one knows why, but magically, Karel can always find a beeper to put down!

 - Important: The `putBeeper()` method let Karel put a beeper at current location. 
 */
WorldModel(streets: 1, avenues: 2).makeKarel(at: Corner(1,2), facing: .east).setBeeperCount(for: .origin, to: 1).setBeeperCount(for: Corner(1,2), to: 1)
Playground.current.show(worldModel: WorldModel(streets: 1, avenues: 2))
//: - Experiment: Try to put down a beeper, like shown above.

putBeeper()
move()


/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
