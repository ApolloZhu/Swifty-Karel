//: [Previous](@previous)
Playground.current.showCoordinates = true
/*:
 # Karel's World

 Karel lives in a world consisting of

 - Streets: running horizontally (east-west), and
 - Avenues: running vertically (north-south).
 - `Corner`: the intersection of a street and an avenue
 
 - Important: Karel can only be positioned on corners, and must be facing one of the four standard compass directions:
    - north
    - south
    - east
    - west

 Here is a sample Karel world. Karel is located at the corner of 1st Street and 1st Avenue, facing east.
 */
let model = WorldModel(streets: 4, avenues: 6).makeKarel(at: Corner(1,1), facing: .east).addWall(from: Point(0,3), to: Point(1,3)).addWall(from: Point(1,3), to: Point(1,6)).setBeeperCount(for: Point(1,2), to: 1)
Playground.current.show(worldModel: model)
//: [Next](@next)
