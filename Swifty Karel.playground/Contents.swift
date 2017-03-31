import UIKit
import PlaygroundSupport

/*:
 # Karel the Robot Learns Swift
 ![](karel.png)
 */

//#-hidden-code
Playground.current.worldView.frame = CGRect(origin: .zero, size: CGSize(side: 400))
Karel.current.frame.size = CGSize(side: 100)
Playground.current.live(worldModel: WorldModel(streets: 3, avenues: 3))
//#-end-hidden-code

//#-editable-code
move()
turnRight()
move()
turnLeft()
move()
turnAround()
move()
//#-end-editable-code

WorldModel(streets: 3, avenues: 3).makeKarel(at: .zero, facing: .north).addWall(from: Point(1,3), to: Point(2,3)).save(withName: "temp")

WorldModel.named("temp")
