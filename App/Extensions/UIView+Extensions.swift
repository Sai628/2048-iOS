//
//  UIView+Extensions.swift
//  UIView Extensions
//
//  Created by Sai on 3/14/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension UIView
{
    convenience init(backgroundColorInt: Int64)
    {
        self.init(backgroundColor: backgroundColorInt.toColor())
    }
    
    
    convenience init(backgroundColor: UIColor)
    {
        self.init()
        self.backgroundColor = backgroundColor
    }
}
