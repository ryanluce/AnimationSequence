//
//  AnimationSequence.swift
//  AnimationTest
//
//  Created by Ryan Luce on 11/20/18.
//  Copyright © 2018 Ryan Luce. All rights reserved.
//

import UIKit

typealias AnimationCompletion = () -> Void
typealias AnimationBlock = () -> Void

final private class Animation {
    fileprivate var completion: AnimationCompletion?
    fileprivate let animations: AnimationBlock?
    fileprivate let animationCurve: UIView.AnimationOptions
    fileprivate let duration: TimeInterval
    
    init(duration: TimeInterval = 0.0, animationCurve: UIView.AnimationOptions = .curveLinear, animations: @escaping AnimationBlock) {
        self.animations = animations
        self.animationCurve = animationCurve
        self.duration = duration
    }
    
    func onCompleted(completion: @escaping AnimationCompletion) -> Self {
        self.completion = completion
        
        return self
    }
    
    func execute() {
        guard let animations = animations else {
            completion?()
            return
        }

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: animationCurve,
                       animations: animations) { (_) in
            self.completion?()
        }
    }
}

class AnimationSequence {
    


    fileprivate var completion:AnimationCompletion?
    fileprivate var sequence = [Animation]()
    
    @discardableResult
    func addAnimation(duration: TimeInterval = 1.0,
                      animationCurve: UIView.AnimationOptions = .curveLinear,
                      _ animations: @escaping AnimationBlock) -> Self {
        let animation = Animation(duration: duration,
                                  animationCurve: animationCurve,
                             animations: animations)
        sequence.append(animation)
        
        return self
    }
    
    @discardableResult
    func onCompletion(_ completion: @escaping AnimationCompletion) -> Self {
        self.completion = completion
        
        return self
    }
    
    func execute() {
        executeSteps()
    }
    
    fileprivate func executeSteps() {
        if sequence.isEmpty == false {
            let step = sequence.removeFirst()
            step.onCompleted {
                    self.executeSteps()
                }
                .execute()
        }
        else {
            completion?()
        }
    }
}
