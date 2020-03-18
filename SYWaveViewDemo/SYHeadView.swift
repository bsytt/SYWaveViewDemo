//
//  SYExamineHeadView.swift
//  Subsidy_Unification
//
//  Created by bsy on 2020/2/4.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit

class SYHeadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubview() {
        self.addSubview(firstWare)
        self.addSubview(secondWaves)
        
        self.addSubview(thirdWare)
        self.addSubview(fouthWaves)
        
    }

    lazy var firstWare: SYWaveView = {
        let wave = SYWaveView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 130),isGradient:true)
        wave.alpha = 0.6
        return wave
    }()
    lazy var secondWaves: SYWaveView = {
        let wave = SYWaveView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 130),isGradient:true)
        wave.waveA = 13
        wave.waveSpeed = 0.06
        wave.alpha = 0.6
        return wave
    }()
    
    lazy var thirdWare: SYWaveView = {
        let wave = SYWaveView(frame: CGRect(x: 0, y: 140, width: self.frame.width, height: 130))
        wave.alpha = 0.6
        return wave
    }()
    lazy var fouthWaves: SYWaveView = {
        let wave = SYWaveView(frame: CGRect(x: 0, y: 140, width: self.frame.width, height:130))
        wave.waveA = 13
        wave.waveSpeed = 0.06
        wave.alpha = 0.6
        return wave
    }()
    
}
