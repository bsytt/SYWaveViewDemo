//
//  ViewController.swift
//  SYWaveViewDemo
//
//  Created by bsy on 2020/3/14.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(waveView)
    }

    lazy var waveView: SYHeadView = {
        let wave = SYHeadView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        return wave
    }()

}

