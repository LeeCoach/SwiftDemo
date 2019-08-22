//
//  DRHUD.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/20.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import PKHUD

private enum DRHUDContentType {
    case success
    case error
    case progress
    case image(UIImage?)
    case rotatingImage(UIImage?)
    
    case labeledSuccess(title: String?, subtitle: String?)
    case labeledError(title: String?, subtitle: String?)
    case labeledProgress(title: String?, subtitle: String?)
    case labeledImage(image: UIImage?, title: String?, subtitle: String?)
    case labeledRotatingImage(image: UIImage?, title: String?, subtitle: String?)
    
    case label(String?)
    case systemActivity
    case customView(view: UIView)
}

class DRHUD: NSObject {
    
    private static let delay  = 2.5
    
    //转圈
    public static func show() {
        
    }
    
    /// 转圈+文字提示 自动隐藏
    public static func showLoading(title:String) {
        PKHUD.sharedHUD.contentView = contentView(.labeledRotatingImage(image: UIImage(named: "hud_progress_activity"), title: title, subtitle: ""))
        PKHUD.sharedHUD.show(onView: nil)
        PKHUD.sharedHUD.hide(afterDelay: delay)
    }
    
    /// 纯文字提示  自动隐藏
    public static func showInfo(title:String?) {
        PKHUD.sharedHUD.contentView = contentView(.label(title))
        PKHUD.sharedHUD.show(onView: nil)
        PKHUD.sharedHUD.hide(afterDelay: delay)
    }
    
    /// 文字提示 + 图片 自动隐藏
    public static func showPrompt(title: String?, subtitle: String?) {
        PKHUD.sharedHUD.contentView = contentView(.labeledImage(image: UIImage(named: "hud_info_icon"), title: title, subtitle: subtitle))
        PKHUD.sharedHUD.show(onView: nil)
        PKHUD.sharedHUD.hide(afterDelay: delay)
    }
    
    /// 成功+纯文字提示 自动隐藏
    public static func showSuccess(title: String?, subtitle: String?) {
        PKHUD.sharedHUD.contentView = contentView(.labeledImage(image: UIImage(named: "hud_success_icon"), title: title, subtitle: subtitle))
        PKHUD.sharedHUD.show(onView: nil)
        PKHUD.sharedHUD.hide(afterDelay: delay)
    }
    
    /// 失败+纯文字提示 自动隐藏
    public static func showError(title: String?, subtitle: String?) {
        PKHUD.sharedHUD.contentView = contentView(.labeledImage(image: UIImage(named: "hud_error_icon"), title: title, subtitle: subtitle))
        PKHUD.sharedHUD.show(onView: nil)
        PKHUD.sharedHUD.hide(afterDelay: delay)
    }
    
    /// 需要控制隐藏
    public static func showProgres(title: String?, subtitle: String?) {
        PKHUD.sharedHUD.contentView = contentView(.labeledProgress(title: title, subtitle: subtitle))
        PKHUD.sharedHUD.show(onView: nil)
    }
    
    public static func hide() {
        PKHUD.sharedHUD.hide()
    }
    
    // MARK: Private methods
    fileprivate static func contentView(_ content: DRHUDContentType) -> UIView {
        switch content {
        case .success:
            return PKHUDSuccessView()
        case .error:
            return PKHUDErrorView()
        case .progress:
            return PKHUDProgressView()
        case let .image(image):
            return PKHUDSquareBaseView(image: image)
        case let .rotatingImage(image):
            return PKHUDRotatingImageView(image: image)
            
        case let .labeledSuccess(title, subtitle):
            return PKHUDSuccessView(title: title, subtitle: subtitle)
        case let .labeledError(title, subtitle):
            return PKHUDErrorView(title: title, subtitle: subtitle)
        case let .labeledProgress(title, subtitle):
            return PKHUDProgressView(title: title, subtitle: subtitle)
        case let .labeledImage(image, title, subtitle):
            return PKHUDSquareBaseView(image: image, title: title, subtitle: subtitle)
        case let .labeledRotatingImage(image, title, subtitle):
            return PKHUDRotatingImageView(image: image, title: title, subtitle: subtitle)
            
        case let .label(text):
            return PKHUDTextView(text: text)
        case .systemActivity:
            return PKHUDSystemActivityIndicatorView()
        case let .customView(view):
            return view
        }
    }

}
