//
//  LoadingAnimationTableVC.swift
//  VK
//
//  Created by Polina Tikhomirova on 26.01.2022.
//

import UIKit

class LoadingAnimationTableVC: UIViewController {

    @IBOutlet var someImageView: UIImageView!
    
    @IBAction func didTapAnimate(_ sender: Any) {
        animate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func animate() {
        let someLayer = CAShapeLayer()
        someLayer.path = UIBezierPath.apple().cgPath
        someLayer.lineWidth = 5.0
        someLayer.strokeColor = UIColor.white.cgColor
        someLayer.fillColor = UIColor.clear.cgColor
        someLayer.strokeStart = 0.0
        someLayer.strokeEnd = 0.0
        
        someImageView.layer.addSublayer(someLayer)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = -0.1
        strokeStartAnimation.toValue = 0.9
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.0
        animationGroup.repeatCount = 3
        animationGroup.animations = [
            strokeStartAnimation,
            strokeEndAnimation,
        ]
        
        someLayer.add(
            animationGroup,
            forKey: nil)
    }
}
