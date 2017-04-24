import UIKit

/// Let Karel display a "Hello WWDC17"
public func helloWWDC17() {
    let config = Playground.current.speed
    Playground.current.speed = .custom(scale: 30)
    let model = WorldModel(streets: 13, avenues: 31).makeKarel(at: Point(12,2), facing: .east)
    Playground.current.show(worldModel: model)

    paintH()
    paintE()
    paintL()
    paintL()
    paintO()

    newLine()

    paintW(color: #colorLiteral(red: 0.84, green: 0.17, blue: 0.28, alpha: 1))
    paintW(color: #colorLiteral(red: 0.16, green: 0.69, blue: 0.81, alpha: 1))
    paintD(color: #colorLiteral(red: 0.12, green: 0.66, blue: 0.58, alpha: 1))
    paintC(color: #colorLiteral(red: 0.88, green: 0.66, blue: 0.19, alpha: 1))
    paint1(color: #colorLiteral(red: 0.23, green: 0.36, blue: 0.44, alpha: 1))
    paint7(color: #colorLiteral(red: 0.9, green: 0.31, blue: 0.27, alpha: 1))

    Playground.current.speed = config
}

var curFillColor = #colorLiteral(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)

func paint(_ count: Int = 1) {
    for _ in 0..<count {
        paintCorner(color: curFillColor)
        move()
    }
}

func move(_ count: Int) {
    for _ in 0..<count {
        move()
    }
}

func paintAndBack(_ count: Int) {
    paint(count)
    turnAround()
    move(count)
}

func paintH() {
    turnRight()
    paint(5)
    turnAround()
    move(3)
    turnRight()
    paint(4)
    turnRight()
    move(2)
    turnAround()
    paint(5)
    turnRight()
    move(2)
    turnRight()
    move()
    turnLeft()
}

func paintE() {
    paintAndBack(5)
    turnLeft()
    paint(2)
    turnLeft()
    paintAndBack(4)
    turnLeft()
    paint(2)
    turnLeft()
    paint(5)
    turnLeft()
    move(4)
    turnRight()
    move()
}

func paintL() {
    turnRight()
    paint(4)
    turnLeft()
    paint(5)
    turnLeft()
    move(4)
    turnRight()
    move()
}

func paintO() {
    for _ in 0..<4 {
        paint(4)
        turnRight()
    }
}

func newLine() {
    turnAround()
    move(position.y - 2)
    turnLeft()
    move(position.x - 6)
    turnLeft()
}

func paintW(color: UIColor) {
    curFillColor = color
    turnRight()
    paint(2)
    turnLeft()
    paint()
    turnRight()
    paintAndBack(3)
    turnRight()
    move()
    turnLeft()
    paintAndBack(2)
    turnLeft()
    move()
    turnRight()
    paintAndBack(3)
    turnRight()
    move()
    turnLeft()
    paint(2)
    turnRight()
    paint()
    move()
}

func paintD(color: UIColor) {
    curFillColor = color
    paintAndBack(4)
    turnLeft()
    paint(4)
    turnLeft()
    paint(4)
    turnLeft()
    move()
    paint(3)
    turnRight()
    move(2)
}

func paintC(color: UIColor) {
    curFillColor = color
    move()
    paintAndBack(3)
    move()
    turnLeft()
    move()
    paint(3)
    turnLeft()
    move()
    paint(3)
    turnLeft()
    move(4)
    turnRight()
    move()
}

func paint1(color: UIColor) {
    curFillColor = color
    turnRight()
    paintAndBack(5)
    turnRight()
    move(2)
}

func paint7(color: UIColor) {
    curFillColor = color
    paint(3)
    turnRight()
    paint(2)
    turnRight()
    move()
    turnLeft()
    paint(3)
}
