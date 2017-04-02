/*:
 # Karel the Robot Learns Swift
 ![](karel.png)
 */

//#-hidden-code
let model = WorldModel(streets: 3, avenues: 3).makeKarel(at: Point(1,1), facing: .north).addWall(from: Point(0,2), to: Point(1,2))
Playground.current.show(worldModel: model)
//#-end-hidden-code

//#-editable-code
turnRight()
move()
turnLeft()
move()
turnRight()
move()
turnRight()
move()
while isBlocked {
    turnLeft()
}
paintCorner(color: .yellow)
move()
move()
//#-end-editable-code
