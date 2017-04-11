//
//  UILabel+Extensions.swift
//  UILabel Extensions
//
//  Created by Sai on 03/04/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension UILabel
{
    convenience init(systemFontSize: CGFloat, colorInt: Int64, isBold: Bool = false)
    {
        self.init(systemFontSize: systemFontSize, textColor: colorInt.toColor(), isBold: isBold)
    }
    
    
    convenience init(systemFontSize: CGFloat, textColor: UIColor, isBold: Bool = false)
    {
        self.init()
        self.font = isBold ? UIFont.boldSystemFont(ofSize: systemFontSize) : UIFont.systemFont(ofSize: systemFontSize)
        self.textColor = textColor
    }
}
