public func runKarel() {
    Playground.current.showCoordinates = true
    let model = WorldModel(streets: 3, avenues: 3).makeKarel(at: .origin, facing: .north).addWall(from: Point(2,3), to: Point(2,1)).setBeeperCount(for: Point(2,2), to: 3)
    Playground.current.show(worldModel: model)

    for _ in 1...6 {
        while !isBlocked {
            if isOnBeeper {
                pickBeeper()
            }
            move()
        }
        while isBlocked {
            turnLeft()
        }
    }

}
