//
//  ViewController.swift
//  ChildLock
//
//  Created by cachico-35c on 2020/04/04.
//

import UIKit

class ViewController: UIViewController ,ChildLockViewDelegate {
    
    // ChildLockView Delegate
    func LockResult(result: Bool) {
        if result {
            alert(message: "ロックを解除しました。\nお好きな処理をどうぞ。", title: "ご注意")
        }else{
            alert(message: "ロックに失敗しました。\nもう一度お試しください。", title: "ご注意")
        }
    }
    var cLockView:ChildLockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnAction(sender:UIButton){
        cLockView = ChildLockView()
        cLockView.initView(view: self.view)
        cLockView.customDelegate = self
        
    }
    
    func alert(message:String,title:String){
        let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Action OK!!")
            
        }
        myAlert.addAction(myOkAction)
        present(myAlert, animated: true, completion: nil)
    }

}

