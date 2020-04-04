//
//  ChildLockView.swift
//  SleepTreatment
//
//  Created by iOS開発 on 2019/12/02.
//  Copyright © 2019 iOS開発. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc protocol ChildLockViewDelegate {
    func LockResult(result: Bool)
}

class ChildLockView: UIView {
    
    var baseView:UIView = UIView()
    var bgScrenn:UIView = UIView()
    var baseScrenn:UIView = UIView()
    var lockScrenn:UIView = UIView()
    var customDelegate:ChildLockViewDelegate?
    var lockPattern:[String] = []
    var lockTag:Int = 0

    var messLabel:UILabel = UILabel()
    var BtnView:UIView = UIView()
    var questionData:JSON = JSON()
    
    let MARGIN_10 = 10
    let MARGIN_20 = 20
    let MARGIN_30 = 30
    
    func initView(view: UIView){
        baseView = view
        baseScrenn.frame = view.frame
//        baseScrenn.backgroundColor = UIColor.black
//        baseScrenn.alpha = 0.0
        baseView.addSubview(baseScrenn)
        
        bgScrenn.frame = view.frame
        bgScrenn.backgroundColor = UIColor.black
        bgScrenn.alpha = 0.0
        baseScrenn.addSubview(bgScrenn)
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapped(_:)))
        baseScrenn.addGestureRecognizer(tapGesture)
        
        lockViewCreate()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bgScrenn.alpha = 0.5
        }, completion: {_ in
            
        })
    }
    func lockViewCreate(){
        
        let lockData:ChildLockData = ChildLockData()
        lockData.createData()
        questionData = lockData.getData()
        print("lockViewCreate:\(questionData)")
        
        let width:CGFloat = baseView.frame.size.width
        let height:CGFloat = baseView.frame.size.height
        lockScrenn.frame = CGRect(
            x: MARGIN_20,
            y: Int((height - (width - CGFloat(MARGIN_20 * 2))/2)/2),
            width: Int(width - CGFloat(MARGIN_20 * 2)),
            height: Int((width - CGFloat(MARGIN_20 * 2))/2)
        )
        lockScrenn.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        lockScrenn.layer.cornerRadius = 15
        // グレー箇所のタップ除外設定（除外するために新たな検知を追加しているので改修したい）
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapped2(_:)))
        lockScrenn.addGestureRecognizer(tapGesture)
        baseScrenn.addSubview(lockScrenn)
        
        let innerWidth:CGFloat = lockScrenn.frame.size.width
        let innerHeight:CGFloat = lockScrenn.frame.size.height
        let itemHeight:CGFloat = (innerHeight - CGFloat(MARGIN_20 + MARGIN_20 + MARGIN_10 + MARGIN_10))/3
        messLabel.frame = CGRect(
            x: MARGIN_20,
            y: MARGIN_20,
            width: Int(innerWidth - CGFloat(MARGIN_20 * 2)),
            height: Int(itemHeight)
        )
        messLabel.textAlignment = .center
        messLabel.text = questionData["question"].string
        lockScrenn.addSubview(messLabel)
        
        BtnView.frame = CGRect(
            x: MARGIN_20,
            y: Int(itemHeight) + MARGIN_20 + MARGIN_10,
            width: Int(innerWidth - CGFloat(MARGIN_20 * 2)),
            height: Int(itemHeight) * 2 + MARGIN_10
        )
//        BtnView.backgroundColor = UIColor.lightGray
        lockScrenn.addSubview(BtnView)
        
        let buttonWidth:Int = Int(BtnView.frame.size.width - CGFloat(MARGIN_10 + MARGIN_10))/3
        for i in 0..<6 {
            let BtnItem:UIButton = UIButton()
            BtnItem.frame = CGRect(
                x: 0 + ((i%3) * (buttonWidth + MARGIN_10)),
                y: 0 + ((i/3) * Int(itemHeight + CGFloat(MARGIN_10))),
                width: buttonWidth,
                height: Int(itemHeight)
            )
            BtnItem.backgroundColor = UIColor.white
            let btnTitle:String = questionData["item"][i]["ans"].string!
            BtnItem.setTitle("\(btnTitle)", for: .normal)
            BtnItem.setTitleColor(.systemBlue, for: .normal)
            BtnItem.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
            BtnItem.tag = i
            BtnView.addSubview(BtnItem)
        }
    }
    @objc func tapAction(sender: UIButton){
        print("TAP:\(sender.tag)")
        
        var bingo:Bool = false
        if questionData["item"][sender.tag]["bool"].string! == "1" {
            bingo = true
        }
        
        self.customDelegate?.LockResult(result: bingo)
        self.baseScrenn.removeFromSuperview()
    }

    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        print("tapped")
        
        UIView.animate(withDuration: 0.2, animations: {
            self.baseScrenn.alpha = 0.0
        }, completion: {_ in
            self.baseScrenn.removeFromSuperview()
        })
        
    }
    @objc func tapped2(_ sender: UITapGestureRecognizer){
        print("tapped2")
    }

}
