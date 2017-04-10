//
//  RowTransformData.swift
//  2048
//
//  Created by Sai on 10/04/2017.
//  Copyright © 2017 Sai. All rights reserved.
//

import Foundation


struct RowTransformData
{
    var datas: [Int]
    var translateInfos: [TranslateInfo]
    var addScore: Int
    
    
    init(datas: [Int], translateInfos: [TranslateInfo], addScore: Int)
    {
        self.datas = datas
        self.translateInfos = translateInfos
        self.addScore = addScore
    }
}
