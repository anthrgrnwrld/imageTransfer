//
//  ViewController.swift
//  ImageTransfer
//
//  Created by Masaki Horimoto on 2015/04/15.
//  Copyright (c) 2015年 Masaki Horimoto. All rights reserved.
//


import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet var imageBeHereNow: UIImageView!
    @IBOutlet var imageDestinationArea: UIImageView!    // 目標Area
    @IBOutlet var imageSourceArea: UIImageView!         // 開始Area
    var startPoint: CGPoint?
    var imageBeHereNowPoint: CGPoint?
    var isImageInside: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageDestinationArea.backgroundColor = UIColor.yellowColor()
        imageSourceArea.backgroundColor = UIColor.orangeColor()
        imageBeHereNow.image = UIImage(named: "BeHereNow.jpg")
        
        imageBeHereNow.userInteractionEnabled = true // 画像のタッチ操作を有効にする
        
        // 枠線部分のタッチ操作を無効にする
        imageDestinationArea.userInteractionEnabled = false
        imageSourceArea.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        
        startPoint = touch.locationInView(self.view) // タッチの開始座標を取得
        imageBeHereNowPoint = imageBeHereNow.frame.origin // 開始時の画像の座標を取得
 
        // タップしたビューがUIImageViewか判断する。
        if touch.view.isKindOfClass(UIImageView) {
            isImageInside = true
        } else {
            isImageInside = false
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if isImageInside! {
            // タッチ中の画像の座標を取得
            let touch = touches.first as! UITouch
            let location = touch.locationInView(self.view)
            
            // 移動量を計算
            let deltaX: CGFloat = CGFloat(location.x - startPoint!.x)
            let deltaY: CGFloat = CGFloat(location.y - startPoint!.y)
  
            // イメージを半透過にする
            imageBeHereNow.layer.opacity = 0.5
            
            // イメージを移動
            self.imageBeHereNow.frame.origin.x = imageBeHereNowPoint!.x + deltaX
            self.imageBeHereNow.frame.origin.y = imageBeHereNowPoint!.y + deltaY
            
        } else {
            // Do nothing
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // タッチ終了時の画像の座標と目標Areaの座標の距離を求める
        let distanceXFromDestination = fabs(imageBeHereNow.frame.origin.x - imageDestinationArea.frame.origin.x)
        let distanceYFromDestination = fabs(imageBeHereNow.frame.origin.y - imageDestinationArea.frame.origin.y)
        
        let threshold: CGFloat = 100
        
        if distanceXFromDestination < threshold && distanceYFromDestination < threshold {
            // アニメーションで目標Areaに吸着させる
            println("perform animation to imageDestinationArea")

            imageBeHereNow.layer.opacity = 1.0
            
            let fromPoint: CGPoint = imageBeHereNow.center
            let toPoint: CGPoint = imageDestinationArea.center
            positonAnimationFromPoint(fromPoint, toPoint: toPoint)
            
            imageBeHereNow.center = imageDestinationArea.center         // イメージを移動

        } else {
            // アニメーションで開始Areaに吸着させる
            println("perform animation to imageSourceArea")
            imageBeHereNow.layer.opacity = 1.0

            let fromPoint: CGPoint = imageBeHereNow.center
            let toPoint: CGPoint = imageSourceArea.center
            positonAnimationFromPoint(fromPoint, toPoint: toPoint)
 
            imageBeHereNow.center = imageSourceArea.center              // イメージを移動
        }
        
    }
    
    func positonAnimationFromPoint(fromPoint: CGPoint!, toPoint: CGPoint!) {
        let positonAnimation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        positonAnimation.fromValue = NSValue(CGPoint: fromPoint)    // アニメーションの開始座標
        positonAnimation.toValue = NSValue(CGPoint: toPoint)        // アニメーションの終了位置
        positonAnimation.repeatCount = 1                            // アニメーションの繰り返し回数
        positonAnimation.duration = 0.1                             // アニメーション時間
        positonAnimation.beginTime = CACurrentMediaTime() + 0       // アニメーションの開始時間を指定
        positonAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)  // アニメーション速度の変化を指定
        imageBeHereNow.layer.addAnimation(positonAnimation, forKey: "move-layer")                           // アニメーション実行
    }
    
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        println("\(__FUNCTION__) is called!!!")
        
    }



}

