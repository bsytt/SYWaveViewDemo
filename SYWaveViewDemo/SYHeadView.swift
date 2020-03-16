//
//  SYExamineHeadView.swift
//  Subsidy_Unification
//
//  Created by bsy on 2020/2/4.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit

class SYExamineHeadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubview() {

    }

    lazy var firstWare: SYWaveView = {
        let wave = SYWaveView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height),isGradient:true)
        wave.alpha = 0.6
        return wave
    }()
    lazy var secondWaves: SYWaveView = {
        let wave = SYWaveView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: self.frame.height),isGradient:true)
        wave.waveA = 13
        wave.waveSpeed = 0.06
        wave.alpha = 0.6
        return wave
    }()
    lazy var headImg: UIImageView = {
        let head = UIImageView(frame: .zero)
        head.layer.cornerRadius = 25
        head.layer.masksToBounds = true
        head.backgroundColor = .cyan
        return head
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel(frame: .zero)
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 14)
        return lab
    }()
}
