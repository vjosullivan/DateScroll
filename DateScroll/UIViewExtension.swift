//
//  UIViewExtension.swift
//  DateScroll
//
//  Created by Vincent O'Sullivan on 30/08/2018.
//  Copyright © 2018 Vincent O'Sullivan. All rights reserved.
//

import UIKit

extension UIView {


    /// Causes the view (if not fully visible) to 'spring' into visibility.
    func fadeIn() {
        guard alpha < 1 else { return }

        transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        alpha = 1
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.375,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = .identity
        },
                       completion: nil)
    }


    /// Causes the view (if not already invisible) to fade into invisibility.
    func fadeOut() {
        guard alpha > 0 else { return }

        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                self.alpha = 0
        },
            completion: nil)
    }
}
