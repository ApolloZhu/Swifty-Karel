/*:
 # Karel the Robot Learns Swift
 ![](Karel.png)
 */

//#-hidden-code
//Playground.current.colorScheme = .default
//Playground.current.showCoordinates = true
//Playground.current.karelImage = #imageLiteral(resourceName: "Origin.png")
//Playground.current.speed = .custom(scale: 3)

let model = WorldModel(streets: 3, avenues: 3).makeKarel(at: Point(1,1), facing: .north).addWall(from: Point(0,2), to: Point(1,2))
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
Playground.current.colorScheme = .default
Playground.current.saveAsWorldModel(withName: "World")
Playground.current.show(worldModel: WorldModel.named("World")!)
//#-end-editable-code
