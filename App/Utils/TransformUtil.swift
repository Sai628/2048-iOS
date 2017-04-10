//
//  TransformUtil.swift
//  2048
//
//  Created by Sai on 10/04/2017.
//  Copyright © 2017 Sai. All rights reserved.
//

import Foundation


struct TransformUtil
{
    //MARK:-
    static func moveToLeft(_ data: [[Int]]) -> AllTileTransformData
    {
        var newArray = getEmptyDatas(row: data.count, column: data.count)
        var translateInfos = getEmptyTranslateInfos(row: data.count, column: data.count)
        var addScore = 0
        
        for i in 0..<data.count
        {
            let rowData = data[i]
            
            let rowTransformData = toLeft(rowData)
            newArray[i] = rowTransformData.datas
            translateInfos[i] = rowTransformData.translateInfos
            addScore += rowTransformData.addScore
        }
        
        return AllTileTransformData(datas: newArray, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func moveToUp(_ data: [[Int]]) -> AllTileTransformData
    {
        let rowLenght = data.count
        let columnLenght = rowLenght
        var newArray = getEmptyDatas(row: rowLenght, column: columnLenght)
        var translateInfos = getEmptyTranslateInfos(row: rowLenght, column: columnLenght)
        var addScore = 0
        
        for i in 0..<columnLenght
        {
            let tempRow = data.map{ $0[i] }
            
            let rowTransformData = toUp(tempRow)
            for (index, num) in rowTransformData.datas.enumerated()
            {
                newArray[index][i] = num
                translateInfos[index][i] = rowTransformData.translateInfos[index]
            }
            
            addScore += rowTransformData.addScore
        }
        
        return AllTileTransformData(datas: newArray, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func moveToRight(_ data: [[Int]]) -> AllTileTransformData
    {
        var newArray = getEmptyDatas(row: data.count, column: data.count)
        var translateInfos = getEmptyTranslateInfos(row: data.count, column: data.count)
        var addScore = 0
        
        for i in 0..<data.count
        {
            let rowData = data[i]
            
            let rowTransformData = toRight(rowData)
            newArray[i] = rowTransformData.datas
            translateInfos[i] = rowTransformData.translateInfos
            addScore += rowTransformData.addScore
        }
        
        return AllTileTransformData(datas: newArray, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func moveToDown(_ data: [[Int]]) -> AllTileTransformData
    {
        let rowLenght = data.count
        let columnLenght = rowLenght
        var newArray = getEmptyDatas(row: rowLenght, column: columnLenght)
        var translateInfos = getEmptyTranslateInfos(row: rowLenght, column: columnLenght)
        var addScore = 0
        
        for i in 0..<columnLenght
        {
            let tempRow = data.map{ $0[i] }
            
            let rowTransformData = toDown(tempRow)
            for (index, num) in rowTransformData.datas.enumerated()
            {
                newArray[index][i] = num
                translateInfos[index][i] = rowTransformData.translateInfos[index]
            }
            
            addScore += rowTransformData.addScore
        }
        
        return AllTileTransformData(datas: newArray, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    //MARK:-
    static func toLeft(_ data: [Int]) -> RowTransformData
    {
        let one = removeLeftEmpty(data, addScore: 0)
        let two = mergeToLeft(one.datas)
        let third = removeLeftEmpty(two.datas, addScore: two.addScore)
        
        let temp = mergeLeft(one: one.translateInfos, two: two.translateInfos)
        let translateInfos = mergeLeft(one: temp, two: third.translateInfos)
        
        return RowTransformData(datas: third.datas, translateInfos: translateInfos, addScore: third.addScore)
    }
    
    
    static func toUp(_ data: [Int]) -> RowTransformData
    {
        let one = removeUpEmpty(data, addScore: 0)
        let two = mergeToUp(one.datas)
        let third = removeUpEmpty(two.datas, addScore: two.addScore)
        
        let temp = mergeUp(one: one.translateInfos, two: two.translateInfos)
        let translateInfos = mergeUp(one: temp, two: third.translateInfos)
        
        return RowTransformData(datas: third.datas, translateInfos: translateInfos, addScore: third.addScore)
    }
    
    
    static func toRight(_ data: [Int]) -> RowTransformData
    {
        let one = removeRightEmpty(data, addScore: 0)
        let two = mergeToRight(one.datas)
        let third = removeRightEmpty(two.datas, addScore: two.addScore)
        
        let temp = mergeRight(one: one.translateInfos, two: two.translateInfos)
        let translateInfos = mergeRight(one: temp, two: third.translateInfos)
        
        return RowTransformData(datas: third.datas, translateInfos: translateInfos, addScore: third.addScore)
    }
    
    
    static func toDown(_ data: [Int]) -> RowTransformData
    {
        let one = removeDownEmpty(data, addScore: 0)
        let two = mergeToDown(one.datas)
        let third = removeDownEmpty(two.datas, addScore: two.addScore)
        
        let temp = mergeDown(one: one.translateInfos, two: two.translateInfos)
        let translateInfos = mergeDown(one: temp, two: third.translateInfos)
        
        return RowTransformData(datas: third.datas, translateInfos: translateInfos, addScore: third.addScore)
    }
    
    
    //MARK:-
    static func removeLeftEmpty(_ data: [Int], addScore: Int) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = getEmptyDatas(length: data.count)
        var j = 0
        
        for i in 0..<data.count
        {
            let number = data[i]
            if number != 0
            {
                resultData[j] = number
                translateInfos[i] = TranslateInfo(deltaX: j - i, deltaY: 0)
                j += 1
            }
            else
            {
                translateInfos[i] = TranslateInfo()
            }
        }
        
        while j < data.count
        {
            resultData[j] = 0
            j += 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func removeUpEmpty(_ data: [Int], addScore: Int) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = getEmptyDatas(length: data.count)
        var j = 0
        
        for i in 0..<data.count
        {
            let number = data[i]
            if number != 0
            {
                resultData[j] = number
                translateInfos[i] = TranslateInfo(deltaX: 0, deltaY: j - i)
                j += 1
            }
            else
            {
                translateInfos[i] = TranslateInfo()
            }
        }
        
        while j < data.count
        {
            resultData[j] = 0
            j += 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func removeRightEmpty(_ data: [Int], addScore: Int) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = getEmptyDatas(length: data.count)
        var j = data.count - 1
        
        for i in stride(from: data.count - 1, through: 0, by: -1)
        {
            let number = data[i]
            if number != 0
            {
                resultData[j] = number
                translateInfos[i] = TranslateInfo(deltaX: j - i, deltaY: 0)
                j -= 1
            }
            else
            {
                translateInfos[i] = TranslateInfo()
            }
        }
        
        while j >= 0
        {
            resultData[j] = 0
            j -= 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func removeDownEmpty(_ data: [Int], addScore: Int) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = getEmptyDatas(length: data.count)
        var j = data.count - 1
        
        for i in stride(from: data.count - 1, through: 0, by: -1)
        {
            let number = data[i]
            if number != 0
            {
                resultData[j] = number
                translateInfos[i] = TranslateInfo(deltaX: 0, deltaY: j - i)
                j -= 1
            }
            else
            {
                translateInfos[i] = TranslateInfo()
            }
        }
        
        while j >= 0
        {
            resultData[j] = 0
            j -= 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func mergeToLeft(_ data: [Int]) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = data
        var addScore = 0
        
        var i = 0
        var j = 1
        while j < data.count
        {
            let numberI = resultData[i]
            let numberJ = resultData[j]
            if (numberI == numberJ && numberI != 0 && numberJ != 0)
            {
                let newNumber = numberI * 2
                resultData[i] = newNumber
                resultData[j] = 0
                translateInfos[j] = TranslateInfo(deltaX: i - j, deltaY: 0)
                
                addScore += newNumber
            }
            
            i += 1
            j += 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func mergeToUp(_ data: [Int]) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = data
        var addScore = 0
        
        var i = 0
        var j = 1
        while j < data.count
        {
            let numberI = resultData[i]
            let numberJ = resultData[j]
            if (numberI == numberJ && numberI != 0 && numberJ != 0)
            {
                let newNumber = numberI * 2
                resultData[i] = newNumber
                resultData[j] = 0
                translateInfos[j] = TranslateInfo(deltaX: 0, deltaY: i - j)
                
                addScore += newNumber
            }
            
            i += 1
            j += 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func mergeToRight(_ data: [Int]) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = data
        var addScore = 0
        
        var i = data.count - 1
        var j = data.count - 2
        while j >= 0
        {
            let numberI = resultData[i]
            let numberJ = resultData[j]
            if (numberI == numberJ && numberI != 0 && numberJ != 0)
            {
                let newNumber = numberI * 2
                resultData[i] = newNumber
                resultData[j] = 0
                translateInfos[j] = TranslateInfo(deltaX: i - j, deltaY: 0)
                
                addScore += newNumber
            }
            
            i -= 1
            j -= 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func mergeToDown(_ data: [Int]) -> RowTransformData
    {
        var translateInfos = getEmptyTranslateInfos(length: data.count)
        var resultData = data
        var addScore = 0
        
        var i = data.count - 1
        var j = data.count - 2
        while j >= 0
        {
            let numberI = resultData[i]
            let numberJ = resultData[j]
            if (numberI == numberJ && numberI != 0 && numberJ != 0)
            {
                let newNumber = numberI * 2
                resultData[i] = newNumber
                resultData[j] = 0
                translateInfos[j] = TranslateInfo(deltaX: 0, deltaY: i - j)
                
                addScore += newNumber
            }
            
            i -= 1
            j -= 1
        }
        
        return RowTransformData(datas: resultData, translateInfos: translateInfos, addScore: addScore)
    }
    
    
    static func mergeLeft(one: [TranslateInfo], two: [TranslateInfo]) -> [TranslateInfo]
    {
        var newTranslateInfos = getEmptyTranslateInfos(length: one.count)
        for i in stride(from: one.count - 1, through: 0, by: -1)
        {
            let deltaX = one[i].deltaX
            if (i + deltaX >= 0)
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: deltaX + two[i+deltaX].deltaX, deltaY: 0)
            }
            else
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: deltaX, deltaY: 0)
            }
        }
        
        return newTranslateInfos
    }
    
    
    static func mergeUp(one: [TranslateInfo], two: [TranslateInfo]) -> [TranslateInfo]
    {
        var newTranslateInfos = getEmptyTranslateInfos(length: one.count)
        for i in stride(from: one.count - 1, through: 0, by: -1)
        {
            let deltaY = one[i].deltaY
            if (i + deltaY >= 0)
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: 0, deltaY: deltaY + two[i+deltaY].deltaY)
            }
            else
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: 0, deltaY: deltaY)
            }
        }
        
        return newTranslateInfos
    }
    
    
    static func mergeRight(one: [TranslateInfo], two: [TranslateInfo]) -> [TranslateInfo]
    {
        var newTranslateInfos = getEmptyTranslateInfos(length: one.count)
        for i in 0..<one.count
        {
            let deltaX = one[i].deltaX
            if (i + deltaX < one.count)
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: deltaX + two[i+deltaX].deltaX, deltaY: 0)
            }
            else
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: deltaX, deltaY: 0)
            }
        }
        
        return newTranslateInfos
    }
    
    
    static func mergeDown(one: [TranslateInfo], two: [TranslateInfo]) -> [TranslateInfo]
    {
        var newTranslateInfos = getEmptyTranslateInfos(length: one.count)
        for i in 0..<one.count
        {
            let deltaY = one[i].deltaY
            if (i + deltaY < one.count)
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: 0, deltaY: deltaY + two[i+deltaY].deltaY)
            }
            else
            {
                newTranslateInfos[i] = TranslateInfo(deltaX: 0, deltaY: deltaY)
            }
        }
        
        return newTranslateInfos
    }
    
    
    static func getEmptyDatas(row: Int, column: Int) -> [[Int]]
    {
        return [[Int]](repeating: [Int](repeating: 0, count: column), count: row)
    }
    
    
    static func getEmptyTranslateInfos(row: Int, column: Int) -> [[TranslateInfo]]
    {
        return [[TranslateInfo]](repeating: [TranslateInfo](repeating: TranslateInfo(), count: column), count: row)
    }
    
    
    static func getEmptyDatas(length: Int) -> [Int]
    {
        return [Int](repeating: 0, count: length)
    }
    
    
    static func getEmptyTranslateInfos(length: Int) -> [TranslateInfo]
    {
        return [TranslateInfo](repeating: TranslateInfo(), count: length)
    }
}
