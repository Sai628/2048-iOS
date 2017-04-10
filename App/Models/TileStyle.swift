//
//  TileStyle.swift
//  2048
//
//  Created by Sai on 10/04/2017.
//  Copyright © 2017 Sai. All rights reserved.
//

import UIKit
import Foundation


struct TileStyle
{
    var bgColor: UIColor
    var textColor: UIColor
    var textSize: CGFloat
    
    
    init(bgColor: UIColor, textColor: UIColor, textSize: CGFloat)
    {
        self.bgColor = bgColor
        self.textColor = textColor
        self.textSize = textSize
    }
}
