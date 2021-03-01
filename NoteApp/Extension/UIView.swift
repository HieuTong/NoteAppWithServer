//
//  UIView.swift
//  NoteApp
//
//  Created by HieuTong on 3/1/21.
//

import UIKit

extension UIView {
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    @discardableResult
    public func right(toView view: UIView, space: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = rightAnchor.constraint(equalTo: view.rightAnchor, constant: space)
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    public func centerY(toView view: UIView, space: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: space)
        constraint.isActive = isActive
        return constraint
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
