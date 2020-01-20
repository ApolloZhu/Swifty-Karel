//
//  ViewController.swift
//  Swifty Karel
//
//  Created by Apollo Zhu on 12/31/17.
//  Copyright © 2017 Swifty Karel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = Playground.current.viewController
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        helloWWDC17()
    }
}
