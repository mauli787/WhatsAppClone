//
//  Spinner.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 13/01/21.
//

import UIKit

struct Spinner {
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    init() {
        
    }
    
    func show(){
        guard let window = UIApplication.shared.keyWindow else { return }
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.init(white: 0.75, alpha: 0.75)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        activityIndicator.hidesWhenStopped = true
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        activityIndicator.startAnimating()
        
        window.addSubview(containerView)
    }
    
    func showInView(_ inView: UIView, inBounds bounds:CGRect){
        containerView.frame = bounds
        containerView.center = inView.center
        containerView.backgroundColor = UIColor.init(white: 0.75, alpha: 0.75)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = inView.center
        progressView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        activityIndicator.startAnimating()
        
        inView.addSubview(containerView)
    }
    func hide(_ completion: (() -> (Void))? = nil) {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
        containerView.removeFromSuperview()
        completion?()
    }
}

