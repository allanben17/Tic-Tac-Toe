//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Tianyi Ben on 2016-01-14.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentPlayer = 1
    
    var cellState = [Int](count: 10, repeatedValue: 0)
    var winningCombinations = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    var gameActive = true
    
    @IBOutlet var winnerLabel: UILabel!
    
    @IBOutlet var playAgain: UIButton!
    
    @IBAction func restart(sender: AnyObject) {
        
        currentPlayer = 1
        cellState = [Int](count: 10, repeatedValue: 0)
        gameActive = true
        
        winnerLabel.text?.removeAll()
        
        winnerLabel.hidden = true
        winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y)
        
        playAgain.hidden = true
        playAgain.center = CGPointMake(playAgain.center.x - 400, playAgain.center.y)
        
        for var i = 1; i < 10; ++i {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(UIImage(), forState: .Normal)
        }
    }
    
    @IBAction func setState(sender: AnyObject) {
        
        if cellState[sender.tag] == 0 && gameActive == true {
            
            var playerIcon = UIImage()
            
            if currentPlayer == 1 {
                playerIcon = UIImage(named: "nought.png")!
            } else {
                playerIcon = UIImage(named: "cross.png")!
            }
            
            sender.setImage(playerIcon, forState: .Normal)
            
            cellState[sender.tag] = currentPlayer
            
            checkWinner()
            
            ++currentPlayer
            if currentPlayer > 2 {currentPlayer = 1}
            
        }
    }
    
    func checkWinner() {
        
        for combination in winningCombinations {
            if cellState[combination[0]] != 0 && cellState[combination[0]] == cellState[combination[1]] && cellState[combination[1]] == cellState[combination[2]] {
                
                gameActive = false
                if gameActive == false {endGame(cellState[combination[0]])}
                
            }
        }
        
        if gameActive == true {
            
            gameActive = false
            for cell in cellState.dropFirst() {
                
                if cell == 0 {
                    gameActive = true
                    break
                }
                
            }
            
            if gameActive == false {endGame(0)}
            
        }
        
        
    }
    
    func endGame(winner: Int) {
        // prompt winner or draw, give an option to play again
        print("winner is \(winner)")
        
        if winner == 0 {
            winnerLabel.text = "It's a Draw!"
        } else if winner == 1 {
            winnerLabel.text = "Nought Won!"
        } else {
            winnerLabel.text = "Cross Won!"
        }
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.winnerLabel.hidden = false
            self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x + 400, self.winnerLabel.center.y)
            
            self.playAgain.hidden = false
            self.playAgain.center = CGPointMake(self.playAgain.center.x + 400, self.playAgain.center.y)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        winnerLabel.hidden = true
        winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y)
        
        playAgain.hidden = true
        playAgain.center = CGPointMake(playAgain.center.x - 400, playAgain.center.y)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

