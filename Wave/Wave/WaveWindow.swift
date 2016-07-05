//
//  WaveWindow.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

//Subclassing UIWindow allows the user to set the window in the App Delegate, and then not worry about it anywhere else in the app. In all essence, this allows the user to access the pullout on any screen in the app
public class WaveWindow: UIWindow {
    
    private var style: PresentationStyle
    private var enabled: Bool
    private var waveViewController: WaveViewController
    
    public init(frame: CGRect, style: PresentationStyle, sections: [SectionType], enabled: Bool) {
        self.style = style
        self.enabled = enabled
        
        self.waveViewController = WaveViewController(frame: frame, sections: sections)
        
        super.init(frame: frame)
        
        if style == .LeftDrawer || style == .Shake {
            fatalError("LeftDrawer and Shake styles are not yet supported. Please use RightDrawer")
        }
    }
    
    public override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            self.presentWave()
        }
        
        super.motionBegan(motion, withEvent: event)
    }
    
    @objc private func presentWave() {
        guard let rootViewController = rootViewController else {
            return
        }
        
        var visibleViewController = rootViewController
        while (visibleViewController.presentedViewController != nil) {
            visibleViewController = visibleViewController.presentedViewController!
        }
        
        if let nav = visibleViewController as? UINavigationController, firstVc = nav.viewControllers.first {
            if !(firstVc is WaveViewController) {
                let navController = UINavigationController(rootViewController: waveViewController)
                visibleViewController.presentViewController(navController, animated: true, completion: nil)
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum PresentationStyle {
    case LeftDrawer
    case RightDrawer
    case Shake
}
