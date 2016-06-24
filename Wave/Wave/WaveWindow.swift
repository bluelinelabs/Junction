//
//  WaveWindow.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import UIKit

//Subclassing UIWindow allows the user to set the window in the App Delegate, and then not worry about it anywhere else in the app. In all essence, this allows the user to access the pullout on any screen in the app
public class WaveWindow: UIWindow {
    
    private var keeper: WaveKeeper
    private var side: Side
    private var isDebug = false
    private var waveViewController: WaveViewController
    
    public init(frame: CGRect, keeper: WaveKeeper, side: Side) {
        self.keeper = keeper
        self.side = side
        
        //There's probably a better way to do this that doesn't rely on the user having this marked in their source somewhere. Maybe pass in a bool to the init on whether or not it's debug, and let the user determine in the app delegate?
        #if DEBUG
            self.isDebug = true
        #endif
        
        self.waveViewController = WaveViewController()
        
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum Side {
    case Left
    case Right
}