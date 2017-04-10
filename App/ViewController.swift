//
//  ViewController.swift
//  2048
//
//  Created by Sai on 10/04/2017.
//  Copyright © 2017 Sai. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController
{
    enum MoveType: Int
    {
        case left
        case right
        case up
        case down
    }
    
    let rowNum = 4
    let columnNum = 4
    let stageNum = 256
    let targeNum = 2048
    let gapSize: CGFloat = 8
    let tileSize: CGFloat = 65
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var rectLabel: UILabel!
    
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var bestValueLabel: UILabel!
    
    @IBOutlet weak var rectView00: UILabel!
    @IBOutlet weak var rectView01: UILabel!
    @IBOutlet weak var rectView02: UILabel!
    @IBOutlet weak var rectView03: UILabel!
    
    @IBOutlet weak var rectView10: UILabel!
    @IBOutlet weak var rectView11: UILabel!
    @IBOutlet weak var rectView12: UILabel!
    @IBOutlet weak var rectView13: UILabel!
    
    @IBOutlet weak var rectView21: UILabel!
    @IBOutlet weak var rectView20: UILabel!
    @IBOutlet weak var rectView22: UILabel!
    @IBOutlet weak var rectView23: UILabel!
    
    @IBOutlet weak var rectView30: UILabel!
    @IBOutlet weak var rectView31: UILabel!
    @IBOutlet weak var rectView32: UILabel!
    @IBOutlet weak var rectView33: UILabel!
    
    
    @IBOutlet weak var tileView00: UILabel!
    @IBOutlet weak var tileView01: UILabel!
    @IBOutlet weak var tileView02: UILabel!
    @IBOutlet weak var tileView03: UILabel!
    
    @IBOutlet weak var tileView10: UILabel!
    @IBOutlet weak var tileView11: UILabel!
    @IBOutlet weak var tileView12: UILabel!
    @IBOutlet weak var tileView13: UILabel!
    
    @IBOutlet weak var tileView20: UILabel!
    @IBOutlet weak var tileView21: UILabel!
    @IBOutlet weak var tileView22: UILabel!
    @IBOutlet weak var tileView23: UILabel!
    
    @IBOutlet weak var tileView30: UILabel!
    @IBOutlet weak var tileView31: UILabel!
    @IBOutlet weak var tileView32: UILabel!
    @IBOutlet weak var tileView33: UILabel!

    
    fileprivate var isFirst: Bool = true
    fileprivate var isBusy: Bool = false
    fileprivate var isStage2: Bool = false
    fileprivate var isWin: Bool = false
    
    var tileViewArray: [[UILabel]] = []
    var tileBgColorStyleArray: [UIColor] = []
    var tileTextColorStyleArray: [UIColor] = []
    var tileTextSizeStyleArray: [CGFloat] = []
    var tileValueArray: [Int] = []
    
    var currentDataArray: [[Int]] = []
    var oldDataArray: [[Int]] = []
    var currentPosition: Position!
    var allTileTransFormData: AllTileTransformData!
    var currentScore: Int = 0

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initResourceData()
        addGestureRecognizer()
        initData()
        
        initDataArrayToGetTwoRandomTile()
        showTwoNewTileView()
    }
    
    
    func initResourceData()
    {
        //给各个View添加圆角效果
        scoreLabel.layer.cornerRadius = 3.0
        bestLabel.layer.cornerRadius = 3.0
        rectLabel.layer.cornerRadius = 5.0
        
        rectView00.layer.cornerRadius = 3.0
        rectView01.layer.cornerRadius = 3.0
        rectView02.layer.cornerRadius = 3.0
        rectView03.layer.cornerRadius = 3.0
        rectView10.layer.cornerRadius = 3.0
        rectView11.layer.cornerRadius = 3.0
        rectView12.layer.cornerRadius = 3.0
        rectView13.layer.cornerRadius = 3.0
        rectView20.layer.cornerRadius = 3.0
        rectView21.layer.cornerRadius = 3.0
        rectView22.layer.cornerRadius = 3.0
        rectView23.layer.cornerRadius = 3.0
        rectView30.layer.cornerRadius = 3.0
        rectView30.layer.cornerRadius = 3.0
        rectView31.layer.cornerRadius = 3.0
        rectView32.layer.cornerRadius = 3.0
        rectView33.layer.cornerRadius = 3.0
        
        let array0: [UILabel] = [tileView00, tileView01, tileView02, tileView03]
        let array1: [UILabel] = [tileView10, tileView11, tileView12, tileView13]
        let array2: [UILabel] = [tileView20, tileView21, tileView22, tileView23]
        let array3: [UILabel] = [tileView30, tileView31, tileView32, tileView33]
        tileViewArray = [array0, array1, array2, array3]
        
        let num2BgColor = UIColor(red: 239.0 / 255.0, green: 230.0 / 255.0, blue: 200.0 / 225.0, alpha: 1.0)
        let num2TextColor = UIColor(red: 126.0 / 255.0, green: 119.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        let num4BgColor = UIColor(red: 239.0 / 255.0, green: 227.0 / 255.0, blue: 205.0 / 225.0, alpha: 1.0)
        let num4TextColor = UIColor(red: 116.0 / 255.0, green: 109.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
        let num8BgColor = UIColor(red: 247.0 / 255.0, green: 178.0 / 255.0, blue: 123.0 / 225.0, alpha: 1.0)
        let num8TextColor = UIColor(red: 255.0 / 255.0, green: 251.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
        let num16BgColor = UIColor(red: 247.0 / 255.0, green: 150.0 / 255.0, blue: 99.0 / 225.0, alpha: 1.0)
        let num16TextColor = UIColor(red: 247.0 / 255.0, green: 248.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        let num32BgColor = UIColor(red: 247.0 / 255.0, green: 124.0 / 255.0, blue: 90.0 / 225.0, alpha: 1.0)
        let num32TextColor = UIColor(red: 253.0 / 255.0, green: 245.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        let num64BgColor = UIColor(red: 247.0 / 255.0, green: 93.0 / 255.0, blue: 57.0 / 225.0, alpha: 1.0)
        let num64TextColor = UIColor(red: 248.0 / 255.0, green: 251.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        let num128BgColor = UIColor(red: 238.0 / 255.0, green: 207.0 / 255.0, blue: 116.0 / 225.0, alpha: 1.0)
        let num128TextColor = UIColor(red: 255.0 / 255.0, green: 241.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
        let num256BgColor = UIColor(red: 239.0 / 255.0, green: 206.0 / 255.0, blue: 99.0 / 225.0, alpha: 1.0)
        let num256TextColor = UIColor(red: 254.0 / 255.0, green: 243.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        let num512BgColor = UIColor(red: 239.0 / 255.0, green: 206.0 / 255.0, blue: 99.0 / 225.0, alpha: 1.0)
        let num512TextColor = UIColor(red: 254.0 / 255.0, green: 243.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        let num1024BgColor = UIColor(red: 239.0 / 255.0, green: 206.0 / 255.0, blue: 99.0 / 225.0, alpha: 1.0)
        let num1024TextColor = UIColor(red: 254.0 / 255.0, green: 243.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        let num2048BgColor = UIColor(red: 239.0 / 255.0, green: 206.0 / 255.0, blue: 99.0 / 225.0, alpha: 1.0)
        let num2048TextColor = UIColor(red: 254.0 / 255.0, green: 243.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        
        tileBgColorStyleArray = [
            num2BgColor, num4BgColor, num8BgColor, num16BgColor, num32BgColor, num64BgColor,
            num128BgColor, num256BgColor, num512BgColor, num1024BgColor, num2048BgColor
        ]
        tileTextColorStyleArray = [
            num2TextColor, num4TextColor, num8TextColor, num16TextColor, num32TextColor, num64TextColor,
            num128TextColor, num256TextColor, num512TextColor, num1024TextColor, num2048TextColor
        ]
        tileTextSizeStyleArray = [54, 54, 54, 42, 42, 42, 30, 30, 30, 24, 24]
        tileValueArray = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048]
    }
    
    
    func addGestureRecognizer()
    {
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(recognizer:)))
        leftRecognizer.direction = .left
        view.addGestureRecognizer(leftRecognizer)
        
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(recognizer:)))
        rightRecognizer.direction = .right
        view.addGestureRecognizer(rightRecognizer)
        
        let upRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(recognizer:)))
        upRecognizer.direction = .up
        view.addGestureRecognizer(upRecognizer)
        
        let downRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(recognizer:)))
        downRecognizer.direction = .down
        view.addGestureRecognizer(downRecognizer)
    }
    
    
    func initData()
    {
        currentDataArray = TransformUtil.getEmptyDatas(row: rowNum, column: columnNum)
        oldDataArray = currentDataArray
        
        isFirst = true
        isBusy = false
        isWin = false
    }
    
    
    func initDataArrayToGetTwoRandomTile()
    {
        var (x1, y1) = (-1, -1)
        var (x2, y2) = (-1, -1)
        
        while (x1 == x2 && y1 == y2)
        {
            x1 = Int(arc4random()) % rowNum
            y1 = Int(arc4random()) % columnNum
            x2 = Int(arc4random()) % rowNum
            y2 = Int(arc4random()) % columnNum
        }
        
        let value1 = (arc4random() % 2) > 1 ? 4 : 2
        let value2 = (arc4random() % 2) > 1 ? 4 : 2
        
        currentDataArray[x1][y1] = value1
        currentDataArray[x2][y2] = value2
    }
    
    
    func showTwoNewTileView()
    {
        var count = 0
        var tileView1: UILabel!
        var tileView2: UILabel!
        var value1: Int = 0
        var value2: Int = 0
        
        for (i, item) in currentDataArray.enumerated()
        {
            for (j, num) in item.enumerated()
            {
                if num != 0
                {
                    if tileView1 == nil
                    {
                        tileView1 = getTileAt(row: i, column: j)
                        value1 = num
                    }
                    else
                    {
                        tileView2 = getTileAt(row: i, column: j)
                        value2 = num
                    }
                    
                    count += 1
                }
                
                if count == 2
                {
                    break
                }
            }
        }
        
        showNewTileView(view: tileView1, tileValue: value1)
        showNewTileView(view: tileView2, tileValue: value2)
    }
    
    
    func showNewTileView(view: UILabel, tileValue value: Int)
    {
        let tileStyle = getTileStyle(value: value)
        
        view.layer.cornerRadius = 3.0
        view.backgroundColor = tileStyle.bgColor
        view.textColor = tileStyle.textColor
        view.font = UIFont.systemFont(ofSize: tileStyle.textSize)
        view.text = "\(value)"
        
        view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(scaleAnimationDidFinish))
        view.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.commitAnimations()
        
        view.isHidden = false
    }
    
    
    func getTileAt(row: Int, column: Int) -> UILabel
    {
        return tileViewArray[row][column]
    }
    
    
    func setTileViewStyle(label: UILabel, value: Int)
    {
        let tileStyle = getTileStyle(value: value)
        
        label.layer.cornerRadius = 3.0
        label.backgroundColor = tileStyle.bgColor
        label.textColor = tileStyle.textColor
        label.font = UIFont.systemFont(ofSize: tileStyle.textSize)
    }
    
    
    func getTileStyle(value: Int) -> TileStyle
    {
        if let index = tileValueArray.index(of: value)
        {
            let bgColor = tileBgColorStyleArray[index]
            let textColor = tileTextColorStyleArray[index]
            let textSize = tileTextSizeStyleArray[index]
            
            return TileStyle(bgColor: bgColor, textColor: textColor, textSize: textSize)
        }
     
        return TileStyle(bgColor: tileBgColorStyleArray[0], textColor: tileTextColorStyleArray[0], textSize: tileTextSizeStyleArray[0])
    }
    
    
    func handleSwipeGesture(recognizer: UISwipeGestureRecognizer)
    {
        guard !isBusy && !isWin else {
            return
        }
        
        isBusy = true
        switch recognizer.direction
        {
        case UISwipeGestureRecognizerDirection.left:
            doMove(type: .left)
        case UISwipeGestureRecognizerDirection.right:
            doMove(type: .right)
        case UISwipeGestureRecognizerDirection.up:
            doMove(type: .up)
        case UISwipeGestureRecognizerDirection.down:
            doMove(type: .down)
        default:
            break
        }
    }
    
    
    func doMove(type: MoveType)
    {
        oldDataArray = currentDataArray
        switch type
        {
        case .left:
            allTileTransFormData = TransformUtil.moveToLeft(currentDataArray)
        case .right:
            allTileTransFormData = TransformUtil.moveToRight(currentDataArray)
        case .up:
            allTileTransFormData = TransformUtil.moveToUp(currentDataArray)
        case .down:
            allTileTransFormData = TransformUtil.moveToDown(currentDataArray)
        }
        
        currentDataArray = allTileTransFormData.datas
        currentScore += allTileTransFormData.addScore
        
        if (allTileTransFormData.addScore > 0)
        {
            scoreValueLabel.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.4)
            scoreValueLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            UIView.commitAnimations()
            
            scoreValueLabel.text = "\(currentScore)"
        }
        
        refreshAllTileView()
        if checkIsWin()
        {
            isWin = true
            showWinDialog()
        }
        else
        {
            let flag = doNextStep()
            if flag
            {
                let view = getTileAt(row: currentPosition.x, column: currentPosition.y)
                showNewTileView(view: view, tileValue: 2)
            }
            else
            {
                isBusy = false
                showLostDialog()
            }
        }
    }
    
    
    func refreshAllTileView()
    {
        for (i, item) in currentDataArray.enumerated()
        {
            for (j, num) in item.enumerated()
            {
                let tileView = getTileAt(row: i, column: j)
                refreshOneTileView(view: tileView, value: num)
            }
        }
    }
    
    
    func refreshOneTileView(view: UILabel, value: Int)
    {
        if value == 0
        {
            view.text = ""
            view.isHidden = true
        }
        else
        {
            let tileStyle = getTileStyle(value: value)
            view.layer.cornerRadius = 3.0
            view.backgroundColor = tileStyle.bgColor
            view.textColor = tileStyle.textColor
            view.font = UIFont.systemFont(ofSize: tileStyle.textSize)
            view.text = "\(value)"
            
            view.isHidden = false
        }
    }
    
    
    func doNextStep() -> Bool
    {
        var emptyPoints: [Position] = []
        for (i, item) in currentDataArray.enumerated()
        {
            for (j, num) in item.enumerated()
            {
                if num == 0
                {
                    emptyPoints.append(Position(x: i, y: j))
                }
            }
        }
        
        if emptyPoints.count > 0
        {
            let newPosition = Int(arc4random()) % emptyPoints.count
            currentPosition = emptyPoints[newPosition]
            currentDataArray[currentPosition.x][currentPosition.y] = 2
            
            return true
        }
        
        return false
    }
    
    
    func checkIsWin() -> Bool
    {
        for item in currentDataArray
        {
            for num in item
            {
                if (num == targeNum)
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    
    func getMaxNum() -> Int
    {
        var maxNum = 0
        currentDataArray.forEach{ $0.forEach{ maxNum = max($0, maxNum) } }
        
        return maxNum
    }
    
    
    func showWinDialog()
    {
        let alert = UIAlertView(title: "恭喜", message: "你胜利了啦!^_^", delegate: self, cancelButtonTitle: "退出", otherButtonTitles: "继续")
        alert.tag = 0
        alert.show()
    }
    
    
    func showLostDialog()
    {
        let alert = UIAlertView(title: "", message: "再接再厉吧~ -_-||", delegate: self, cancelButtonTitle: "退出", otherButtonTitles: "再来一局")
        alert.tag = 1
        alert.show()
    }
    
    
    func moveX(time: CFTimeInterval, x: Int) -> CABasicAnimation
    {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.toValue = x
        animation.duration = time
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        
        return animation
    }
    
    
    func moveY(time: CFTimeInterval, y: Int) -> CABasicAnimation
    {
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.toValue = y
        animation.duration = time
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        
        return animation
    }
    
    
    func scaleAnimationDidFinish()
    {
        isBusy = false
    }
}


extension ViewController: UIAlertViewDelegate
{
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        if (buttonIndex == alertView.cancelButtonIndex)
        {
            exit(0)
        }
        else if (buttonIndex == 1)
        {
            initData()
            refreshAllTileView()
            initDataArrayToGetTwoRandomTile()
            showTwoNewTileView()
        }
    }
}
