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
    var stageNumber:Int = 1
    
    var countDownTimer:Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        decideTheme()
        enableButton()
    }

    func decideTheme(){
        themeNumber = Int.random(in: 10...20)
        themeText.text = String(themeNumber)
        countDownTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.stageLose), userInfo: nil, repeats: false)
    }
    
    func nextStage() {
        countDownTimer.invalidate()
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
    
    func stageWin(){
        resultImage.image = UIImage(named: "good")
        if(stageNumber <= 9){
            nextStage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resultImage.image = nil
        }
    }
    
    @objc func stageLose() {
        resultImage.image = UIImage(named: "bad")
        if(stageNumber <= 9){
            nextStage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resultImage.image = nil
        }
    }
    
    @IBAction func pushButton(buttonNum:Int){
        turn = !turn
        gameNumber = gameNumber + 1;
        print(gameNumber)
        gameText.text = String(gameNumber)
        
        if(gameNumber == themeNumber){
            
            stageWin()
            
        }else if(gameNumber > themeNumber){
            
            stageLose()
        }
        enableButton()
        
    }
    
    
    
    
}

