//
//  DRCornerShadow.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/26.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

class DRCornerShadow: UIView {
    
}

extension UIView {
    
    
    /// 圆角、边框
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - roundingCorners: 全角集
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框色
    func dr_setCornerRadius(cornerRadius:CGFloat,roundingCorners:UIRectCorner,borderWidth:CGFloat? = 0,borderColor:UIColor? = nil) {
        addSetCornerShadow(cornerRadius: cornerRadius, roundingCorners: roundingCorners , shadowOffset: CGSize.zero, shadowRadius: 0, shadowColor: nil, shadowOpacity: 0, borderWidth: borderWidth ?? 0, borderColor: borderColor)
    }
    
    
    /// 圆角、阴影、边框
    ///
    /// - Parameters:
    ///   - shadowRadius: 阴影半径
    ///   - shadowOffset: 阴影范围
    ///   - shadowColor: 阴影颜色
    ///   - shadowOpacity: 阴影透明度(默认为1)
    ///   - cornerRadius: 圆角半径
    ///   - roundingCorners: 圆角集
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框色
    func dr_setShadowRadius(shadowRadius:CGFloat,shadowOffset:CGSize,shadowColor:UIColor,shadowOpacity:CGFloat,borderWidth:CGFloat?,borderColor:UIColor? = nil,cornerRadius:CGFloat?,roundingCorners:UIRectCorner) -> Void {
        addSetCornerShadow(cornerRadius: cornerRadius ?? 0, roundingCorners: roundingCorners, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: shadowColor, shadowOpacity: 0, borderWidth: borderWidth ?? 0, borderColor: borderColor)
    }
    
    /// 边框
    ///
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框色
    func dr_setBorder(borderWidth:CGFloat,borderColor:UIColor) -> Void {
        addSetCornerShadow(cornerRadius: 0, roundingCorners: .allCorners, shadowOffset: CGSize.zero, shadowRadius: 0, shadowColor: nil, shadowOpacity: 0, borderWidth: borderWidth, borderColor: borderColor)
    }
    
//    func dr_setCornerRadius(cornerRadius:CGFloat,roundingCorners:UIRectCorner) {
//        addSetCornerShadow(cornerRadius: cornerRadius, roundingCorners: roundingCorners, shadowOffset: CGSize.zero, shadowRadius: 0, shadowColor: nil, shadowOpacity: 0, borderWidth: 0, borderColor: nil)
//    }
    
    // MARK: 绘制圆角，阴影，边框
    /// 绘制圆角，阴影，边框
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - roundingCorners: 圆角集
    ///   - shadowOffset: 阴影范围
    ///   - shadowRadius: 阴影半径
    ///   - shadowColor: 阴影颜色
    ///   - shadowOpacity: 阴影透明度(默认为1)
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框色
    private func addSetCornerShadow(cornerRadius:CGFloat,roundingCorners:UIRectCorner,shadowOffset:CGSize,shadowRadius:CGFloat,shadowColor:UIColor? = nil,shadowOpacity:CGFloat,borderWidth:CGFloat,borderColor:UIColor? = nil) {
        
//        if self.bounds.size.width != 0 && self.bounds.size.height != 0 {
        
            if shadowOpacity > 0,cornerRadius > 0 {
                // view (阴影视图)
                var view = self.superview?.viewWithTag(996)
                if view == nil {
                    view = UIView.init(frame: self.frame)
                    view?.tag = 996
                    view?.backgroundColor = UIColor.clear
                    self.superview?.insertSubview(view!, belowSubview: self)
                }
                setShadowWithView(view: view!, cornerRadius: cornerRadius, roundingCorners: roundingCorners, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: shadowColor ?? UIColor.clear, shadowOpacity: shadowOpacity)
            } else {
                setShadowWithView(view: self, cornerRadius: cornerRadius, roundingCorners: roundingCorners, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: shadowColor ?? UIColor.clear, shadowOpacity: shadowOpacity)
            }
            
            if ((cornerRadius > 0 && roundingCorners != .allCorners) || shadowOpacity > 0) {
                // 圆角和边框的贝塞尔曲线
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
                // 圆角
                if cornerRadius > 0 {
                    let maskLayer = CAShapeLayer.init()
                    maskLayer.frame = self.bounds
                    maskLayer.path = path
                    self.layer.mask = maskLayer
                }
                // 边框
                if borderWidth > 0 {
                    let maskLayer = CAShapeLayer.init()
                    maskLayer.frame = self.bounds
                    maskLayer.path = path
                    maskLayer.lineWidth = borderWidth
                    maskLayer.strokeColor = borderColor?.cgColor ?? UIColor.clear.cgColor
                    maskLayer.fillColor = UIColor.clear.cgColor
                    self.layer.addSublayer(maskLayer)
                }
                
            } else {
                // 没有圆角时，直接添加边框
                self.layer.masksToBounds = true
                self.layer.cornerRadius = cornerRadius
                self.layer.borderWidth = borderWidth
                self.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
            }
            
//        } else {
//            addSetCornerShadow(cornerRadius: cornerRadius, roundingCorners: roundingCorners, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: shadowColor ?? UIColor.clear, shadowOpacity: shadowOpacity, borderWidth: borderWidth, borderColor: borderColor)
//        }
        
    }
    
    // MARK: 设置阴影
    private func setShadowWithView(view:UIView,cornerRadius:CGFloat,roundingCorners:UIRectCorner,shadowOffset:CGSize,shadowRadius:CGFloat,shadowColor:UIColor,shadowOpacity:CGFloat) {
        
        if cornerRadius > 0 {
            let shadowPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            view.layer.shadowPath = shadowPath
        }
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = Float(shadowOpacity)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowColor = shadowColor.cgColor
    }
    
}
