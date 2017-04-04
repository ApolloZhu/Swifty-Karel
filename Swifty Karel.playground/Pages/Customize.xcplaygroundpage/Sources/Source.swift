public func runKarel() {
    let model = WorldModel(streets: 3, avenues: 3).addWall(from: Point(0,2), to: Point(1,2))
    Playground.current.show(worldModel: model)

    for _ in 1...4 {
        while !isBlocked {
            move()
        }
        while isBlocked {
            turnLeft()
        }
    }
}
