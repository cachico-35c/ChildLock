//
//  ChildLockData.swift
//  SleepTreatment
//
//  Created by iOS開発 on 2019/12/03.
//  Copyright © 2019 iOS開発. All rights reserved.
//

import UIKit
import SwiftyJSON

// 配列シャッフル用のextension
extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            self.swapAt(i, j)
        }
    }
}
class ChildLockData: NSObject {
    
//    let pt1:JSON = JSON()
    let pt1_question:String = "5 x 6 ="
    let pt1_item:[String] = ["20", "24", "30", "35", "42", "56"]
    let pt1_answer:[String] = ["0", "0", "1", "0", "0", "0"]
//    let pt2:JSON = JSON()
    let pt2_question:String = "6 x 7 ="
    let pt2_item:[String] = ["13", "21", "30", "42", "49", "67"]
    let pt2_answer:[String] = ["0", "0", "0", "1", "0", "0"]
//    let pt3:JSON = JSON()
    let pt3_question:String = "3 x 9 ="
    let pt3_item:[String] = ["12", "19", "27", "35", "39", "55"]
    let pt3_answer:[String] = ["0", "0", "1", "0", "0", "0"]
    
    var selectPt:JSON = JSON()
    var selectPt_question:String = ""
    var selectPt_item:[String] = []
    var selectPt_answer:[String] = []
    
    func createData(){
        let iValue = Int.random(in: 1 ... 3)
//        Logs.d(mess: "iValue:\(iValue)")
        if iValue == 1 {
            selectPt_question = pt1_question
            selectPt_item = pt1_item
            selectPt_answer = pt1_answer
        }else if iValue == 2 {
            selectPt_question = pt2_question
            selectPt_item = pt2_item
            selectPt_answer = pt2_answer
        }else if iValue == 3 {
            selectPt_question = pt3_question
            selectPt_item = pt3_item
            selectPt_answer = pt3_answer
        }
        
//        Logs.d(mess: "selectPt1:\(selectPt_item)")
//        Logs.d(mess: "selectPt2:\(selectPt_answer)")
        
        var numbers = [0, 1, 2, 3, 4, 5]
        numbers.shuffle()
        
        selectPt["question"] = JSON(selectPt_question)
        var pool:[JSON] = []
        for i in 0..<6 {
            let num:Int = Int(numbers[i])
            var tmp:JSON = JSON()
            tmp["ans"] = JSON(selectPt_item[num])
            tmp["bool"] = JSON(selectPt_answer[num])
            pool.append(tmp)
        }
        selectPt["item"] = JSON(pool)
        
//        Logs.d(mess: "selectPt:\(selectPt)")
    }
    
    func getData()->JSON {
        return selectPt
    }

}
