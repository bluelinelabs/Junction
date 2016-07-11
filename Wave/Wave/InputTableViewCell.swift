//
//  InputTableViewCell.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/11/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let label = UITextField(frame: CGRect(x: 16, y: 0, width: frame.width, height: frame.height))
        label.placeholder = "Type In Me"
        
        addSubview(label)
    }
}
