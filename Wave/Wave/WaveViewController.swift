//
//  WaveViewController.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import UIKit

final public class WaveViewController: UIViewController {
    //The controller that will manage the actual sidebar
    
    private var waveKeeper: WaveKeeper
    
    public init(waveKeeper: WaveKeeper) {
        self.waveKeeper = waveKeeper
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
