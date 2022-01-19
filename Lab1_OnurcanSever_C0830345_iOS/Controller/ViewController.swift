//
//  ViewController.swift
//  Lab1_OnurcanSever_C0830345_iOS
//
//  Created by Onurcan Sever on 2022-01-17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    @IBOutlet weak var cell1: UIButton!
    @IBOutlet weak var cell2: UIButton!
    @IBOutlet weak var cell3: UIButton!
    @IBOutlet weak var cell4: UIButton!
    @IBOutlet weak var cell5: UIButton!
    @IBOutlet weak var cell6: UIButton!
    @IBOutlet weak var cell7: UIButton!
    @IBOutlet weak var cell8: UIButton!
    @IBOutlet weak var cell9: UIButton!
    
    private var game = Game()
    private lazy var cells: [UIButton] = [cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeToReset()
    }
    
    @IBAction func gameBoardPressed(_ sender: UIButton) {
        
        if game.winner == .none {
            game.start()
            if (sender.image(for: .normal) == nil) {
                if (game.currentPlayer == .player1) {
                    playerLabel.text = "Player 1's Turn"
                    playerLabel.textColor = .systemGreen
                    
                    sender.setTitle(game.turn.rawValue, for: .normal)
                    sender.imageView?.alpha = 0
                                        
                    UIView.animate(withDuration: 1.2) {
                        sender.imageView?.alpha = 1
                        sender.setImage(UIImage(named: self.game.turn.rawValue), for: .normal)
                        
                    }
                                        
                }
                else if (sender.image(for: .normal)) == nil {
                    if (game.currentPlayer == .player2) {
                        playerLabel.text = "Player 2's Turn"
                        playerLabel.textColor = .systemRed
                        
                        let x = sender.frame.origin.x
                        let y = sender.frame.origin.y
                        
                        let height = sender.frame.size.height
                        let width = sender.frame.size.width
                        
                        sender.setTitle(game.turn.rawValue, for: .normal)
                        sender.imageView?.frame = CGRect(x: x, y: y, width: 0, height: 0)
                        
                            UIView.animate(withDuration: 1.2) {
                            sender.setImage(UIImage(named: self.game.turn.rawValue), for: .normal)
                            sender.imageView?.frame = CGRect(x: x, y: y, width: width, height: height)
                        }
                    }
                }
                sender.isEnabled = false
            }
        }
        
        if isDraw() {
            game.end()
            playerLabel.text = "Draw!"
            return
        }
        
        if game.determineTheWinner(cellTitles: getCellTitles(), turn: Game.Turn.cross) {
            game.winner = .player1
            game.incrementScore()
            player1ScoreLabel.text = "Player 1: \(game.player1Score)"
            playerLabel.text = "Player 1 (Cross) has won!"
            playerLabel.textColor = .systemGreen
            game.winner = .none
        }
        
        if game.determineTheWinner(cellTitles: getCellTitles(), turn: Game.Turn.nought) {
            game.winner = .player2
            game.incrementScore()
            player2ScoreLabel.text = "Player 2: \(game.player2Score)"
            playerLabel.text = "Player 2 (Nought) has won!"
            playerLabel.textColor = .systemRed
            game.winner = .none
        }
        
        /*
         if game.determineTheWinner(cellTitles: getCellTitles(), turn: Game.Turn.cross) {
             game.player1Score += 1
             player1ScoreLabel.text = "Player 1: \(game.player1Score)"
             playerLabel.text = "Player 1 (Cross) has won!"
             playerLabel.textColor = .systemGreen
             game.winner = .player1
         }
         
         if game.determineTheWinner(cellTitles: getCellTitles(), turn: Game.Turn.nought) {
             game.player2Score += 1
             player2ScoreLabel.text = "Player 2: \(game.player2Score)"
             playerLabel.text = "Player 2 (Nought) has won!"
             playerLabel.textColor = .systemRed
             game.winner = .player2
         }
         */
        
        
        
    }
    
    private func getCellTitles() -> [String] {
        var cellTitles: [String] = [String]()
        
        for cell in cells {
            cellTitles.append(cell.title(for: .normal) ?? game.turn.rawValue)
        }
        
        return cellTitles
    }
    
    
    private func swipeToReset() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized(_:)))
        gesture.direction = .left
        view.isUserInteractionEnabled = true
        
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc private func swipeRecognized(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            for cell in cells {
                cell.setImage(nil, for: .normal)
                cell.setTitle(nil, for: .normal)
                cell.isEnabled = true
            }
            game.reset()
            game.winner = .none
            playerLabel.text = ""
        }
        
    }
    
    private func isDraw() -> Bool {
        for cell in cells {
            if cell.image(for: .normal) == nil {
                return false
            }
        }
        
        return true
    }
    
    private func determineWinner() -> Game.Player {
        if game.determineTheWinner(cellTitles: getCellTitles(), turn: Game.Turn.cross) {
            return .player1
        }
        
        return .player2
    }
 
    
}

/*
 game.start()
 if (sender.image(for: .normal) == nil) {
     if (game.currentPlayer == .player1) {
         playerLabel.text = "Player 1's Turn"
         playerLabel.textColor = .systemGreen
         
         sender.setTitle(game.turn.rawValue, for: .normal)
         sender.imageView?.alpha = 0
                             
         UIView.animate(withDuration: 1.2) {
             sender.imageView?.alpha = 1
             sender.setImage(UIImage(named: self.game.turn.rawValue), for: .normal)
             
         }
                             
     }
     else if (sender.image(for: .normal)) == nil {
         if (game.currentPlayer == .player2) {
             playerLabel.text = "Player 2's Turn"
             playerLabel.textColor = .systemRed
             
             let x = sender.frame.origin.x
             let y = sender.frame.origin.y
             
             let height = sender.frame.size.height
             let width = sender.frame.size.width
             
             sender.setTitle(game.turn.rawValue, for: .normal)
             sender.imageView?.frame = CGRect(x: x, y: y, width: 0, height: 0)
             
                 UIView.animate(withDuration: 1.2) {
                 sender.setImage(UIImage(named: self.game.turn.rawValue), for: .normal)
                 sender.imageView?.frame = CGRect(x: x, y: y, width: width, height: height)
             }
         }
     }
     sender.isEnabled = false
     game.end()

 }
 */
