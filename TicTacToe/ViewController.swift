//
//  ViewController.swift
//  TicTacToe
//
//  Created by Benoit Dufort on 2018-12-14.
//  Copyright © 2018 Benoit Dufort. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var activePlayer = 1
    var gameStates = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 = empty, 1 = noughts, 2 = cross
    
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetGame()
    }


    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        if activePlayer == 0 {
            return
        }
        
        let activePosition = sender.tag - 1
        
        if gameStates[activePosition] == 0 {
        
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
                gameStates[activePosition] = 1
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
                gameStates[activePosition] = 2
            }
            checkIfWinning(currentState: gameStates[activePosition])
        }
    }
    
    func checkIfWinning(currentState: Int) {
        
        for combination in winningCombinations {
            var winner = true
            for item in combination {
                if gameStates [item] == 0 || gameStates[item] != currentState {
                    winner = false
                    break
                }
            }
            if winner {
                if currentState == 1 {
                    winnerLabel.text = "Noughts has won!"
                }
                else {
                    winnerLabel.text = "Crosses has won!"
                }
                activePlayer = 0
                winnerLabel.isHidden = false
                playAgainButton.isHidden = false
                
                UIView.animate(withDuration: 1) {
                    self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                    self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
                }
            }
        }
            
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        resetGame()
    }
    
    func resetGame() {
    
        gameStates = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        activePlayer = 1
        
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
}

