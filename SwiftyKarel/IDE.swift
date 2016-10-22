//
//  IDE.swift
//  SwiftyKarel
//
//  Created by Apollonian on 10/10/16.
//
//

/// Basic functionality of Karel IDE
public protocol AZKarelIDE {
    var speed: Int { get set }
    var world: World { get set }
    func load(world: World)
    func run(_ commands: () throws -> ())
    func showError(_ error: Error)
}

extension AZKarelIDE {
    func move() {
        do{
            try world.moveKarel(speed: speed)
        } catch {
            showError(error)
        }
    }
}
