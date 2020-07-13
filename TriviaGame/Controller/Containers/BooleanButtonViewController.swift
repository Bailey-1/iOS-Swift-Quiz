//
//  BooleanButtonViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 09/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

protocol BooleanButtonViewControllerDelegate {
    func submittedAnswer(answer: String)
}

class BooleanButtonViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    // Define a collection for both buttons
    @IBOutlet var allButtons: [UIButton]!
    
    // Set up delegate so this class can call a method in GameViewController for when the button is pressed.
    var delegate: BooleanButtonViewControllerDelegate?
    
    // Create an array for possible answers with the text for the label and the correct bool for if it is correct or not
    // Used for UI colours
    var answers: [Answers] = [Answers(text: "", correct: false),
                              Answers(text: "", correct: false)]
        
    var selectedAnswer: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        // Use this to block any sequential button presses after the first
        // Stops buttons being pressed for next questions
        if selectedAnswer == nil {
            selectedAnswer = sender
        } else {
            return
        }
        
        // Stop buttons from being pressed maybe not required
//        DispatchQueue.main.async {
//            for button in self.allButtons {
//                button.isEnabled = false
//            }
//        }
        
        // Check if the answer was correct and change UI accordingly
        for answer in self.answers {
            if sender.currentTitle == answer.text {
                if answer.correct == true {
                    DispatchQueue.main.async {
                        sender.backgroundColor = UIColor.green
                        sender.setTitleColor(UIColor.black, for: .normal)
                    }
                } else {
                    DispatchQueue.main.async {
                        sender.backgroundColor = UIColor.red
                        sender.setTitleColor(UIColor.black, for: .normal)
                    }
                }
            }
        }
        
        // Set a timer to a function to send the answer and change UI back to normal
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendAnswer), userInfo: nil, repeats: false)
    }
    
    @objc func sendAnswer(){
        // Submit answer to GameViewController
        delegate?.submittedAnswer(answer: selectedAnswer!.currentTitle!)
        
        // Set UI back to normal
        DispatchQueue.main.async {
            self.button1.backgroundColor = UIColor.black
            self.button1.setTitleColor(UIColor.white, for: .normal)
            
            self.button2.backgroundColor = UIColor.black
            self.button2.setTitleColor(UIColor.white, for: .normal)
        }
    }
}

extension BooleanButtonViewController: GameViewControllerDelegate {
    func clearUI() {
        // Not required since true and false stay in the same buttons
    }
    
    // Allow GameViewController to update Answers a
    func updateUI(answers: [Answers]) {
        self.answers = answers
        
        // Allow user to press and submit a button again
        selectedAnswer = nil
        
//        DispatchQueue.main.async {
//            for button in self.allButtons {
//                button.isEnabled = true
//            }
//        }
    }
}
