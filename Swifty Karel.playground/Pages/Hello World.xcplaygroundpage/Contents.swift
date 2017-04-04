/*:
 # Karel the Robot Learns Swift
 ![](Karel.png)
 */

let model = WorldModel(streets: 3, avenues: 3).makeKarel(at: .origin, facing: .north).addWall(from: Point(0,2), to: Point(1,2))
Playground.current.show(worldModel: model)
//#-end-hidden-code

//#-editable-code
pickBeeper()
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
paintCorner(color: .tianyi)
putBeeper()
for i in 0..<2 {
    move()
    for _ in 0...i {
        putBeeper()
    }
}
paintCorner(color: .green)

//#-end-editable-code
