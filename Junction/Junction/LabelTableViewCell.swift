//
//  LabelTableViewCell.swift
//  Junction
//
//  Created by Eric Kuck on 8/9/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

internal class LabelTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        NSLayoutConstraint(item: label, attribute: .LeadingMargin, relatedBy: .Equal, toItem: contentView, attribute: .LeadingMargin, multiplier: 1, constant: 16).active = true
        NSLayoutConstraint(item: label, attribute: .TrailingMargin, relatedBy: .Equal, toItem: contentView, attribute: .TrailingMargin, multiplier: 1, constant: -16).active = true
        NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
