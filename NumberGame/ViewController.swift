//
//  ViewController.swift
//  NumberGame
//
//  Created by Sakura on 2020/07/21.
//  Copyright © 2020 Sakura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var themeText:UILabel!
    @IBOutlet var gameText:UILabel!
    @IBOutlet var numBtn01,numBtn02,numBtn03,numBtn04,numBtn05,numBtn06:UIButton!
    @IBOutlet var resultImage:UIImageView!
    @IBOutlet var countDownSlider:UISlider!
    var themeNumber:Int = 0
    var gameNumber:Int = 0
    var turn:Bool = false //falseは1人めtrueは2人め
    var result:Bool!
    var stageNumber:Int = 1
    
    var countDownTimer:Timer!
    var countNum:Float = 5
    
    var limitTimer:Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        decideTheme()
        enableButton()
    }

    func decideTheme(){
        themeNumber = Int.random(in: 10...20)
        themeText.text = String(themeNumber)
        countNum = 5
        countDownTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.displaySlider), userInfo: nil, repeats: true)
        limitTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.stage), userInfo: nil, repeats: false)
    }
    
    func nextStage() {
        limitTimer.invalidate()
        gameNumber = 0
        gameText.text = String(gameNumber)
        decideTheme()
        stageNumber = stageNumber + 1
    }
    
    func enableButton(){
        if(turn == false){
            numBtn01.isEnabled = true
            numBtn02.isEnabled = true
            numBtn03.isEnabled = true
            numBtn04.isEnabled = false
            numBtn05.isEnabled = false
            numBtn06.isEnabled = false
        }else if(turn == true){
                   
            numBtn01.isEnabled = false
            numBtn02.isEnabled = false
            numBtn03.isEnabled = false
            numBtn04.isEnabled = true
            numBtn05.isEnabled = true
            numBtn06.isEnabled = true
        }
    }
    
    @objc func displaySlider(){
        countNum = countNum - 0.1
        countDownSlider.value = countNum
    }
    
    //trueが勝ち,falseが負け
    @objc func stage(){
        countDownTimer.invalidate()
        switch result {
        case true:
            resultImage.image = UIImage(named: "good")
        default:
            resultImage.image = UIImage(named: "bad")
        }
        if(stageNumber <= 9){
            nextStage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resultImage.image = nil
        }
    }
    
    @IBAction func pushButton(sender:UIButton){
        turn = !turn
        gameNumber = gameNumber + sender.tag;
        
        gameText.text = String(gameNumber)
        
        if(gameNumber == themeNumber){
            result = true
            stage()
            
        }else if(gameNumber > themeNumber){
            result = false
            stage()
        }
        enableButton()
        
    }
    
    
    
    
}

