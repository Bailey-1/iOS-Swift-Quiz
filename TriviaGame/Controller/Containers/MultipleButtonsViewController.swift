//
//  MultipleButtonsViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 09/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

protocol MultipleButtonViewControllerDelegate {
    func submittedAnswer(answer: String)
}

class MultipleButtonViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet var allButtons: [UIButton]!
    
    var selectedAnswer: UIButton?
        
    var delegate: MultipleButtonViewControllerDelegate?
    var answers: [Answers] = [Answers(text: "", correct: false),
                              Answers(text: "", correct: false),
                              Answers(text: "", correct: false),
                              Answers(text: "", correct: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        // Block multiple button presses
        if selectedAnswer == nil {
            selectedAnswer = sender
        } else {
            return
        }
        
//        DispatchQueue.main.async {
//            for button in self.allButtons {
//                button.isEnabled = false
//            }
//        }

        // Check if the answer was correct and change UI accordingly
        for answer in self.answers {
            if sender.currentTitle == answer.text {
                if answer.correct == true {
//                    sender.backgroundColor = UIColor.green
//                    sender.setTitleColor(UIColor.black, for: .normal)
                    
                    DispatchQueue.main.async {
                        sender.backgroundColor = UIColor.green
                        sender.setTitleColor(UIColor.black, for: .normal)
                    }
                } else {
//                    sender.backgroundColor = UIColor.red
//                    sender.setTitleColor(UIColor.black, for: .normal)
                    
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
        delegate?.submittedAnswer(answer: selectedAnswer!.currentTitle!)
        DispatchQueue.main.async {
            self.button1.backgroundColor = UIColor.black
            self.button1.setTitleColor(UIColor.white, for: .normal)
            
            self.button2.backgroundColor = UIColor.black
            self.button2.setTitleColor(UIColor.white, for: .normal)
            
            self.button3.backgroundColor = UIColor.black
            self.button3.setTitleColor(UIColor.white, for: .normal)
            
            self.button4.backgroundColor = UIColor.black
            self.button4.setTitleColor(UIColor.white, for: .normal)
        }
    }
}

extension MultipleButtonViewController: GameViewControllerDelegate {
    func updateUI(answers: [Answers]) {
        self.answers = answers
        DispatchQueue.main.async {
//            for button in self.allButtons {
//                button.isEnabled = true
//            }
            
            self.button1.setTitle(answers[0].text.htmlAttributedString!.string, for: .normal)
            self.button2.setTitle(answers[1].text.htmlAttributedString!.string, for: .normal)
            self.button3.setTitle(answers[2].text.htmlAttributedString!.string, for: .normal)
            self.button4.setTitle(answers[3].text.htmlAttributedString!.string, for: .normal)
            self.selectedAnswer = nil
        }
    }
    
    func clearUI(){
        DispatchQueue.main.async {
            self.button1.setTitle("A", for: .normal)
            self.button2.setTitle("A", for: .normal)
            self.button3.setTitle("A", for: .normal)
            self.button4.setTitle("A", for: .normal)
        }
    }
}
