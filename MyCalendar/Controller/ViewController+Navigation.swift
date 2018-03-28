//
//  ViewController+Navigation.swift
//  MyCalendar
//
//  Created by Jason Fan on 27/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

extension ViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let originFrame = self.selectedFrame else { return nil }
        
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            let dateDetailVC = toVC as! DateDetailViewController
            guard let headView = dateDetailVC.headerView else { return nil }
            let animator = CustomAnimator(isPresenting: true, duration: TimeInterval(UINavigationControllerHideShowBarDuration), originFrame: originFrame, transView: headView)
            return animator
        default:
            let dateDetailVC = fromVC as! DateDetailViewController
            guard let headView = dateDetailVC.headerView else { return nil }
            let animator = CustomAnimator(isPresenting: false, duration: TimeInterval(UINavigationControllerHideShowBarDuration), originFrame: originFrame, transView: headView)
            return animator
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let customInteractor = self.customInteractor else { return nil }
        return customInteractor.transitionInProgress ? customInteractor : nil
    }
}
