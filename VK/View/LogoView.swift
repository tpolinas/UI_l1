//
//  LogoView.swift
//  VK
//
//  Created by Polina Tikhomirova on 24.12.2021.
//

import UIKit

extension UIBezierPath {
    static func vkLogo() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 12.8, y: 25.3))
        path.addCurve(to: CGPoint(x: 4, y: 15.3), controlPoint1: CGPoint(x: 7.3, y: 25.3), controlPoint2: CGPoint(x: 4.2, y: 21.5))
        path.addLine(to: CGPoint(x: 6.8, y: 15.3))
        path.addCurve(to: CGPoint(x: 10.5, y: 22.2), controlPoint1: CGPoint(x: 15.8, y: 19.9), controlPoint2: CGPoint(x: 8.9, y: 21.8))
        path.addLine(to: CGPoint(x: 10.5, y: 15.3))
        path.addLine(to: CGPoint(x: 13.1, y: 15.3))
        path.addLine(to: CGPoint(x: 13.1, y: 19.3))
        path.addCurve(to: CGPoint(x: 16.9, y: 15.3), controlPoint1: CGPoint(x: 14.7, y: 36.3), controlPoint2: CGPoint(x: 16.3, y: 17.3))
        path.addLine(to: CGPoint(x: 19.5, y: 15.3))
        path.addLine(to: CGPoint(x: 16.6, y: 15.3))
        path.addLine(to: CGPoint(x: 16.6, y: 18.9))
        path.close()
        return path
    }
}

final class SomeRootView: UIView {
    
    override class var layerClass: AnyClass {
        CALayer.self
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.black.cgColor)
        let path = UIBezierPath.vkLogo().cgPath
        context.addPath(path)
        context.strokePath()
    }
}

