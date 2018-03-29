//
//  CustomAnimator.swift
//  MyCalendar
//
//  Created by Jason Fan on 27/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool
    var duration: TimeInterval
    var originFrame: CGRect
    var transView: DateHeaderView?
    
    init?(isPresenting: Bool, duration: TimeInterval, originFrame: CGRect, transView: DateHeaderView?) {
        self.isPresenting = isPresenting
        self.duration = duration
        self.originFrame = originFrame
        self.transView = transView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        transView?.alpha = 0
        
        let replaceTransView = DateHeaderView(frame: isPresenting ? originFrame : (transView?.frame)!)
        replaceTransView.backgroundColor = Config.getColor(red: 255, green: 90, blue: 90)
        replaceTransView.layer.cornerRadius = replaceTransView.frame.size.width / 2
        replaceTransView.layer.masksToBounds = true
        replaceTransView.dateLabel.text = transView?.dateLabel.text
        container.addSubview(replaceTransView)
        replaceTransView.layoutIfNeeded()
        
        let scale: CGFloat = self.isPresenting ? 0.3 : 1.0
        replaceTransView.dateLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            replaceTransView.frame = self.isPresenting ? (self.transView?.frame)! : self.originFrame
            replaceTransView.layer.cornerRadius = replaceTransView.frame.size.width / 2
            replaceTransView.layer.masksToBounds = true
            replaceTransView.layoutIfNeeded()
            let scale: CGFloat = self.isPresenting ? 1.0 : 0.3
            replaceTransView.dateLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }) { (isFinished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            replaceTransView.removeFromSuperview()
            self.transView?.alpha = 1
        }
    }
    

}
