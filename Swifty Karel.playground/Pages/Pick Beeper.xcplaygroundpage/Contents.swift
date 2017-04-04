/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Pick Beeper
 Karel also like to collect beepers on the floor. Karel can only pick up one beeper at a time.
 - Important: The `pickBeeper()` method let Karel pick up one beeper at current location. If there is no beeper there, Karel will complain about it!
 */
WorldModel(streets: 1, avenues: 1)
Playground.current.show(worldModel: WorldModel(streets: 1, avenues: 1).setBeeperCount(for: .origin, to: 1))
//: - Experiment: Try to pick up a beeper, like shown above.



/*:
 ****
[Previous](@previous) | [Next](@next)
 */
