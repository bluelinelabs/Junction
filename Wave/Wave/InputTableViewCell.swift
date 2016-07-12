//
//  InputTableViewCell.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/11/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

internal class InputTableViewCell: UITableViewCell {

    lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 16, y: 0, width: self.frame.width - 32, height: self.frame.height))
        textField.placeholder = "Custom Option"
        textField.clearButtonMode = .WhileEditing
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(textField)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
