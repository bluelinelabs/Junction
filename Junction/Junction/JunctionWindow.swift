//
//  JunctionWindow.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

//Subclassing UIWindow allows the user to set the window in the App Delegate, and then not worry about it anywhere else in the app. In all essence, this allows the user to access the pullout on any screen in the app
internal final class JunctionWindow: UIWindow {
    
    private var style: PresentationStyle
    private var enabled: Bool
    private var junctionViewController: JunctionViewController
    
    internal init(frame: CGRect, style: PresentationStyle, sections: [SectionType], enabled: Bool) {
        self.style = style
        self.enabled = enabled
        
        self.junctionViewController = JunctionViewController(frame: frame, sections: sections)
        
        super.init(frame: frame)
        
        if style == .LeftDrawer || style == .RightDrawer {
            fatalError("LeftDrawer and RightDrawer styles are not yet supported. Please use Shake")
        }
    }
    
    internal override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake && style == .Shake && enabled {
            self.presentJunction()
        }
        
        super.motionBegan(motion, withEvent: event)
    }
    
    private func presentJunction() {
        guard let rootViewController = rootViewController else {
            return
        }
        
        var visibleViewController = rootViewController
        while (visibleViewController.presentedViewController != nil) {
            visibleViewController = visibleViewController.presentedViewController!
        }
        
        if let nav = visibleViewController as? UINavigationController, firstVc = nav.viewControllers.first {
            if !(firstVc is JunctionViewController) {
                let navController = UINavigationController(rootViewController: junctionViewController)
                junctionViewController.prepareForDisplay()
                visibleViewController.presentViewController(navController, animated: true, completion: nil)
            }
        }
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum PresentationStyle {
    case LeftDrawer
    case RightDrawer
    case Shake
}
