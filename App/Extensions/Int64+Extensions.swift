//
//  Int64+Extensions.swift
//  Int64 Extensions
//
//  Created by Sai on 3/14/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension Int64
{
    func toColor() -> UIColor
    {
        return UIColor(red: CGFloat((self & 0x00FF0000) >> 16) / 255.0,
                       green: CGFloat((self & 0x0000FF00) >> 8) / 255.0,
                       blue: CGFloat(self & 0x000000FF) / 255.0,
                       alpha: CGFloat((self & 0xFF000000) >> 24) / 255.0)
    }
}
