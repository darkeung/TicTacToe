//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by NG CHUN KEUNG on 14/4/18.
//  Copyright © 2018 NG CHUN KEUNG. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var xwincount: UILabel!
    @IBOutlet weak var tiecount: UILabel!
    @IBOutlet weak var owincount: UILabel!
    @IBOutlet weak var musicBtn: UIButton!

    
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0]
    let winning = [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15], [0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15], [0,5,10,15], [3,6,9,12]]
    var btnArrayarrayar : NSMutableArray = NSMutableArray.init()
    var Isaction = true
    var audioPlayer: AVAudioPlayer?
    var oneP = true
    var xplayerwin = 0
    var oplayerwin = 0
    var tie = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        musicplayer()
    }
    
    
    
    
    @IBAction func musicplay (_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            audioPlayer?.pause()
        }else{
            sender.isSelected = true
            audioPlayer?.play()
        }
    }
    
    @IBAction func onetwochoose(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            oneP = true
        }
        else
        {
            oneP = false
        }
        reset()
        xplayerwin = 0
        oplayerwin = 0
        tie = 0
        xwincount.text = "\(xplayerwin)"
        owincount.text = "\(oplayerwin)"
        tiecount.text = "\(tie)"
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        reset()
    }
    @IBAction func action(_ sender: UIButton)
    {
        
        if gameState[sender.tag-1] == 0 && Isaction == true
        {
            if oneP == true
            {
                activePlayer = 1;
                gameState[sender.tag-1] = activePlayer
                sender.setTitle("X", for: .normal);
                sender.setTitleColor(UIColor.black, for: .normal)
                clickedBtn()
                check()
                computerMove()
            }
            else
            {
                gameState[sender.tag-1] = activePlayer
                if activePlayer == 1
                {
                    sender.setTitle("X", for: .normal);
                    sender.setTitleColor(UIColor.black, for: .normal)
                    activePlayer = 2
                    
                }
                else
                {
                    sender.setTitle("O", for: .normal);
                    sender.setTitleColor(UIColor.red, for: .normal)
                    activePlayer = 1
                }
                check()
            }
        }
        print(gameState);
    }
    func reset() {
        Isaction = true;
        btnArrayarrayar.removeAllObjects()
        gameState = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        for subView in self.view.subviews {
            if subView.tag > 0 && subView.tag < 17 {
                let btn = subView as! UIButton
                btn.setTitle("", for: .normal)
                btnArrayarrayar.add(btn)
            }
        }
    }
    func computerMove() {
        if Isaction == true && btnArrayarrayar.count > 0{
            activePlayer = 2
            
            let index = arc4random()%UInt32(btnArrayarrayar.count)
            
            let nextBtn = btnArrayarrayar.object(at: Int(index)) as! UIButton
            
            if gameState[nextBtn.tag-1] == 0
            {
                nextBtn.setTitle("O", for: .normal)
                nextBtn.setTitleColor(UIColor.red, for: .normal)
                gameState[nextBtn.tag-1] = activePlayer
                
                check()
            }
        }
    }
    
    func check() {
        var Draw = true;
        var winMessage:String = "Draw";
        
        for combination in winning
        {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] &&  gameState[combination[2]] ==  gameState[combination[3]]
            {
                Isaction = false
                
                if gameState[combination[0]] == 1
                {
                    winMessage = "X Player win!"
                    xplayerwin += 1
                    xwincount.text = "\(xplayerwin)"
                }
                else
                {
                    winMessage = "O Player win!"
                    oplayerwin += 1
                    owincount.text = "\(oplayerwin)"
                }
                
                Alert(winMessage: winMessage)
                
                return
            }
        }
    
        for placeState in gameState{
            if placeState == 0 {
                Draw = false
            }
        }
        
        if Draw == true {
            
            tie += 1
            tiecount.text = "\(tie)"
            Alert(winMessage: winMessage)
        }
    }
    func clickedBtn() {
        for subview in self.view.subviews {
            if subview.tag > 0 && subview.tag < 10 {
                let btn = subview as! UIButton
                if ((btn.title(for: UIControlState(rawValue: 0))) != ""){
                    btnArrayarrayar .remove(btn)
                }
            }
        }
    }
    func Alert(winMessage: String) {
        let winAlert = UIAlertController.init(title: "Alert", message: winMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil);
        winAlert.addAction(cancelAction)
        
        self.present(winAlert, animated: true, completion: nil);
    }
        
        
    func musicplayer() {
        
        let path = Bundle.main.path(forResource: "Nightcore - [Butterfly] Primary Yuiko", ofType: "mp3")
        let pathURL = NSURL.init(fileURLWithPath: path!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pathURL as URL)
        } catch {
            audioPlayer = nil
        }
        
        if audioPlayer != nil {
            audioPlayer?.prepareToPlay();
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

