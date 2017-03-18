//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let karel = Karel(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
let corner = Corner(.zero, size: 200, backgroundColor: .green)
corner.addSubview(karel)
PlaygroundPage.current.liveView = corner
