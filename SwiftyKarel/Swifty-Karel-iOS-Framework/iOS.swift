//
//  iOS.swift
//  SwiftyKarel
//
//  Created by Apollonian on 10/10/16.
//
//

import Foundation

extension SuperKarel{
    func paintBlock(color: UIColor){
        paintBlock(color: color.cgColor)
    }
    func paintBlock(color: CIColor){
        paintBlock(color: UIColor(ciColor: color).cgColor)
    }
    var colorOfBlock: UIColor{
        return UIColor(cgColor: colorOfBlock)
    }
}
