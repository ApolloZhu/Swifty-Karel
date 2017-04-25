/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Pick Beeper
 Karel also like to collect beepers on the floor. Karel can only pick up one beeper at a time.
 - Important: The `pickBeeper()` method let Karel pick up one beeper at current location. If there is no beeper there, Karel will complain about it!
 */
WorldModel(streets: 1, avenues: 2).makeKarel(at: Corner(1,2), facing: .east)
Playground.current.show(worldModel: WorldModel(streets: 1, avenues: 2).setBeeperCount(for: .origin, to: 1).setBeeperCount(for: Corner(1,2), to: 1))
//: - Experiment: Try to pick up a beeper, like shown above.

pickBeeper()
move()


/*:
 ****
[Previous](@previous) | [Next](@next)
 */
