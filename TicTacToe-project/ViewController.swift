//
//  ViewController.swift
//  TicTacToe-project
//
//  Created by Tarin on 8/8/2566 BE.
//

import UIKit

class ViewController: UIViewController {
    enum Turn {
        case Nought
        case Cross
    }

    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn  = Turn.Cross
    var currentTurn = Turn.Cross
    var NOUGHT = "O"
    var CROSS = "X"
    var board  = [UIButton]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        // Do any additional setup after loading the view.
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkForVictory(CROSS)
        {
            resultAlert(title: "Crosses Wins!")
        }
        
        else if checkForVictory(NOUGHT)
        {
            resultAlert(title: "Noughts Wins!")
        }
        
        if (fullBoard()) {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ symbol: String) -> Bool {
        // Check rows
        for row in 0..<3 {
            if thisSymbol(board[row * 3], symbol) &&
               thisSymbol(board[row * 3 + 1], symbol) &&
               thisSymbol(board[row * 3 + 2], symbol) {
                return true
            }
        }
        
        // Check columns
        for col in 0..<3 {
            if thisSymbol(board[col], symbol) &&
               thisSymbol(board[col + 3], symbol) &&
               thisSymbol(board[col + 6], symbol) {
                return true
            }
        }
        
        // Check diagonals
        if thisSymbol(board[0], symbol) &&
           thisSymbol(board[4], symbol) &&
           thisSymbol(board[8], symbol) {
            return true
        }
        
        if thisSymbol(board[2], symbol) &&
           thisSymbol(board[4], symbol) &&
           thisSymbol(board[6], symbol) {
            return true
        }
        
        return false
    }

    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.setTitleColor(.black, for: .normal) // Reset title color
            button.isEnabled = true
        }
        
        if (firstTurn == Turn.Nought) {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        } else if (firstTurn == Turn.Cross) {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
        
        // Update the UI on the main thread
        DispatchQueue.main.async {
            self.view.setNeedsLayout()  // Forces layout update
        }
    }

    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    func addToBoard(_ sender: UIButton)
    {
        if (sender.title(for: .normal) == nil)
        {
            if (currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
                    
            }
            
            else if (currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
                    
            }
            sender.isEnabled = false
        }
    }
        
}

