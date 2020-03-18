//
//  SYWaveView.swift
//  Subsidy_Unification
//
//  Created by bsy on 2020/2/4.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit
/*
y =Asin（ωx+φ）+C
A表示振幅，也就是使用这个变量来调整波浪的高度
ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
*/
class SYWaveView: UIView {

    private var wavesDisplayLink : CADisplayLink!
    private var wavesLayer : CAShapeLayer!
    private var gradientLayer : CAGradientLayer!
    private var offsetX : CGFloat = 0       //位移
    private var isGradient : Bool!          //是否使用渐变色
    
    var waveA : CGFloat = 12        //水纹振幅
    var waveW : CGFloat = 0.4/30.0  //水纹周期
    var currentK : CGFloat = 0      //当前波浪高度Y
    var waveSpeed : CGFloat = 0.08     //水纹速度
    var wavesWidth : CGFloat = 0    //水纹宽度
    
    //波浪颜色
    var wavesColor : UIColor?{
        didSet {
            wavesLayer.fillColor = self.wavesColor?.cgColor
        }
    }
    //渐变色位置
    var locations : [NSNumber]? {
        didSet {
            gradientLayer.locations = locations
        }
    }
    //渐变色方向=========默认是2
    /**
     1.  startPoint：0，0  endPoint：1，1  表示左上到右下渐变
     2.  startPoint：0，0  endPoint：1，0  表示从左到右渐变
     3.  startPoint：0，0  endPoint：0，1  表示从上到下渐变
     4.  startPoint：0，0  endPoint：0，0  不渐变使用第一个颜色
     5.  startPoint：1，1  endPoint：1，1  不渐变使用第一个颜色
     8.  startPoint：1，1  endPoint：1，0  从下到上
     9.  startPoint：1，1  endPoint：0，1  从左到右colors颜色倒序
     10. startPoint：1，1  endPoint：0，0  从左上到右下colors颜色倒序
     11. startPoint：1，0  endPoint：1，1  同3
     12.  startPoint：1，0  endPoint：1，0  不渐变使用第一个颜色
     13.  startPoint：1，0  endPoint：0，1  右上到左下
     14.  startPoint：1，0  endPoint：0，0  左到右颜色倒序
     15.  startPoint：0，1  endPoint：1，1  同2
     16.  startPoint：0，1  endPoint：1，0  右上到左下颜色倒序
     17.  startPoint：0，1  endPoint：0，1  不渐变使用第一个颜色
     18.  startPoint：0，1  endPoint：0，0  从下到上颜色倒序
     */
    var startPoint : CGPoint?{
        didSet{
            gradientLayer.startPoint = startPoint ?? CGPoint(x: 0, y: 0)
        }
    }
    
    var endPoint : CGPoint?{
        didSet{
            gradientLayer.endPoint = endPoint ?? CGPoint(x: 1, y: 0)
        }
    }
    //===============
    
    //渐变色数组
    var colors : [Any]?{
        didSet{
            gradientLayer.colors = colors
        }
    }

    init(frame: CGRect,isGradient:Bool=false) {
        super.init(frame: frame)
        self.isGradient = isGradient
        initSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubview() {
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        setUpWaves()
    }
    
    func setUpWaves() {
        //设置波浪宽度
        wavesWidth = self.frame.width
        //波浪纵向位置
        currentK = self.frame.height-waveA
        if wavesLayer == nil {
            wavesLayer = CAShapeLayer()
            //设置闭环的颜色
            wavesLayer.fillColor = UIColor.themeColor
                .cgColor
            self.layer.addSublayer(wavesLayer)
            if isGradient {
                gradientLayer = CAGradientLayer()
                gradientLayer.frame = bounds
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0)
                gradientLayer.locations = [0,0.5,1]
                gradientLayer.colors = [UIColor(hexString: "#0F1E90").cgColor,UIColor(hexString: "#275AFF").cgColor]
                self.layer.addSublayer(gradientLayer)
                gradientLayer.mask = wavesLayer
            }
        }
        //启动定时器
        wavesDisplayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave(displayLink:)))
        wavesDisplayLink.add(to: RunLoop.main, forMode: .common)
    }
    
    @objc func getCurrentWave(displayLink:CADisplayLink) {
        //实时位移
        offsetX += waveSpeed
        setCurrentFirstWaveLayerPath()
    }
    
    func setCurrentFirstWaveLayerPath() {
        //创建一个路径
        let path = CGMutablePath()
        var y = currentK
        //将点移动到x=0，y=currentK的位置
        path.move(to: CGPoint(x: 0, y: y))
        for i in 0..<Int(wavesWidth+1) {
            //正弦函数波浪公式
            y = waveA * sin(waveW*CGFloat(i)+offsetX)+currentK
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
        }
        path.addLine(to: CGPoint(x: wavesWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        wavesLayer.path = path
    }
    
    deinit {
        self.wavesDisplayLink.invalidate()
    }
}
