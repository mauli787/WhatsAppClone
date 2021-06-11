//
//  UIView+Extension.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 13/01/21.
//

import UIKit
 
extension UIView {
    
    func addConstraintsWithVisualStrings(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    func bindToTheKeyboard(_ bottomConstaint: NSLayoutConstraint? = nil) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: bottomConstaint)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curveframe = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = targetFrame.origin.y - curveframe.origin.y
        
        if let constraint = notification.object as? NSLayoutConstraint {
            constraint.constant = deltaY
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
                self.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
                self.frame.origin.y += deltaY
            }, completion: nil)
        }
    }
}
