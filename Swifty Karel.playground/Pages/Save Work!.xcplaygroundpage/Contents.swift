/*:
 [Previous](@previous) | [Next](@next)
 ****
 Playground is highly customizable. See the example below.
 */


let model = WorldModel(streets: 3, avenues: 3).makeKarel(at: .origin, facing: .north).addWall(from: Point(0,2), to: Point(1,2))
Playground.current.show(worldModel: model)

//: Save current world to file
Playground.current.saveAsWorldModel(withName: "File")
//: Save current world to image
Playground.current.saveAsImage(withName: "Image")
Playground.current.show(worldModel: WorldModel.named("World")!)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
