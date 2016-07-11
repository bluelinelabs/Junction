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
        
    }
    
    func configureCell() {
        let textField = UITextField(frame: CGRect(x: 16, y: 0, width: frame.width, height: frame.height))
        textField.placeholder = "Custom Option"
        
        addSubview(textField)
    }
}
