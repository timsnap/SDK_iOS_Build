//
//  Ext + UIVIew.swift
//  CarbonCard
//
//  Created by Precious Osaro on 29/01/2021.
//  Copyright © 2021 Precious Osaro. All rights reserved.
//

import Foundation
import UIKit


public extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView,
                 topAnchor: NSLayoutYAxisAnchor? = nil,
                 paddingTop: CGFloat? = 0,
                 width: CGFloat? = nil,
                 height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
        
        if let width = width, let height = height {
            setDimensions(width: width, height: height)
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func addSubview(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func addSubview(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}


extension UIView {
    public func addRippleAnimation(
        color: UIColor,
        rippleWidth: CGFloat = 2,
        duration: Double = 3.0,
        rippleCount: Int = 3,
        rippleDistance: CGFloat? = 100,
        expandMaxRatio ratio: CGFloat = 1,
        startReset: Bool = true,
        handler: ((CAAnimation) -> Void)? = nil
    ) {
        if startReset {
            removeRippleAnimation()
        } else {
            if isRippleAnimating {
                return
            }
        }
        let rippleAnimationAvatarSize = frame.size
        let rippleAnimationLineWidth: CGFloat = rippleWidth
        let rippleAnimationDuration: Double = duration
        var rippleAnimationExpandSizeValue: CGFloat = 0
        
        if let distance = rippleDistance {
            rippleAnimationExpandSizeValue = distance
        } else {
            rippleAnimationExpandSizeValue = rippleAnimationAvatarSize.width / 3.0
        }
        
        let initPath = UIBezierPath(
            ovalIn: CGRect(
                x: 0,
                y: 0,
                width: rippleAnimationAvatarSize.width,
                height: rippleAnimationAvatarSize.height
            )
            .insetBy(dx: rippleAnimationLineWidth,
                     
                     dy: rippleAnimationLineWidth))
        
        let finalPath = UIBezierPath(
            ovalIn: CGRect(
                x: -rippleAnimationExpandSizeValue * ratio,
                y: -rippleAnimationExpandSizeValue * ratio,
                width: rippleAnimationAvatarSize.width
                + rippleAnimationExpandSizeValue
                * 2
                * ratio,
                height: rippleAnimationAvatarSize.height
                + rippleAnimationExpandSizeValue
                * 2
                * ratio
            )
            .insetBy(
                dx: rippleAnimationLineWidth,
                dy: rippleAnimationLineWidth
            )
        )
        clipsToBounds = false
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = rippleCount
        replicator.instanceDelay = rippleAnimationDuration / Double(rippleCount)
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.name = "ReplicatorForRipple"
        layer.addSublayer(replicator)
        
        let shape = animationLayer(path: initPath, color: color, lineWidth: rippleWidth)
        shape.name = "ShapeForRipple"
        shape.frame = CGRect(
            x: 0,
            y: 0,
            width: rippleAnimationAvatarSize.width,
            height: rippleAnimationAvatarSize.height
        )
        replicator.addSublayer(shape)
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.isRemovedOnCompletion = true
        pathAnimation.fromValue = initPath.cgPath
        pathAnimation.toValue = finalPath.cgPath
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1)
        opacityAnimation.toValue = NSNumber(value: 0)
        
        let groupAnimation = CAAnimationGroup()
        handler?(groupAnimation)
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = rippleAnimationDuration
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.fillMode = .forwards
        shape.add(groupAnimation, forKey: "RippleGroupAnimation")
    }
    
    public func removeRippleAnimation() {
        var layers: [CALayer] = []
        layer.sublayers?.forEach { layer in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                replicator.sublayers?.forEach { ly in
                    if ly.name == "ShapeForRipple" {
                        ly.isHidden = true
                        layers.append(ly)
                    }
                }
                replicator.isHidden = true
                layers.append(replicator)
            }
        }
        
        for i in 0 ..< layers.count {
            layers[i].removeFromSuperlayer()
        }
        layers.removeAll()
    }
    
    private func animationLayer(
        path: UIBezierPath,
        color: UIColor,
        lineWidth: CGFloat
    ) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        shape.strokeColor = color.cgColor
        shape.lineCap = .round
        return shape
    }
    
    public var isRippleAnimating: Bool {
        var animating = false
        layer.sublayers?.forEach { layer in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                animating = true
            }
        }
        return animating
    }
}

extension UIView {
    func showSnappayLoader() {
        let snappayLoader = SnappayLoader(frame: frame)
        self.addSubview(snappayLoader)
    }

    func removeSnappayLoader() {
        if let blurLoader = subviews.first(where: { $0 is SnappayLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}
