//
//  TranslateInfo.swift
//  2048
//
//  Created by Sai on 10/04/2017.
//  Copyright © 2017 Sai. All rights reserved.
//

import Foundation


struct TranslateInfo
{
    var deltaX: Int
    var deltaY: Int
    
    
    init(deltaX: Int = 0, deltaY: Int = 0)
    {
        self.deltaX = deltaX
        self.deltaY = deltaY
    }
}
