//
//  InputTableViewCell.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/11/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

internal class InputTableViewCell: UITableViewCell {

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .WhileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(textField)

        NSLayoutConstraint(item: textField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: contentView, attribute: .LeadingMargin, multiplier: 1, constant: 16).active = true
        NSLayoutConstraint(item: textField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: contentView, attribute: .TrailingMargin, multiplier: 1, constant: -16).active = true
        NSLayoutConstraint(item: textField, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: textField, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1, constant: 0).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
            textField.becomeFirstResponder()
        }
    }
    
}
