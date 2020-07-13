//
//  GameViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 09/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate {
    func updateUI(answers: [Answers])
    func clearUI()
}

class GameViewController: UIViewController {
    
    // Link views to the two type of answer options
    @IBOutlet weak var multipleButtonView: UIView!
    @IBOutlet weak var booleanButtonView: UIView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var settingsOptions: SettingsOptions?
    
    var gameManager = GameManager()
        
    var multipleDelegate: GameViewControllerDelegate?
    var booleanDelegate: GameViewControllerDelegate?

    // Hide navigationbar on the welcome screen
    override func viewWillAppear(_ animated: Bool) {
        // Always call super when overiding method from the super class
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        gameManager.delegate = self
    }
    
    // Unhide the navigation bar to show it on other screens
    override func viewWillDisappear(_ animated: Bool) {
        // Always call super when overiding method from the super class
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Pass settings data to the gameManger
        if let safeSettingsOptions = settingsOptions {
            print(safeSettingsOptions)
            gameManager.fetchQuizData(settingsOptions: safeSettingsOptions)
        }
    }
    
    // Send data to view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.containers.showMultiple {
            let destinationVC = segue.destination as! MultipleButtonViewController //Chose the right view controller. - Downcasting
            destinationVC.delegate = self
            multipleDelegate = destinationVC
            
        } else if segue.identifier == K.segue.containers.showBoolean {
            let destinationVC = segue.destination as! BooleanButtonViewController //Chose the right view controller. - Downcasting
            destinationVC.delegate = self
            booleanDelegate = destinationVC
            
        } else if segue.identifier == K.segue.showEndScreen {
            let destinationVC = segue.destination as! EndScreenViewController //Chose the right view controller. - Downcasting

            print("Going to end screen now")
            destinationVC.total = settingsOptions!.numberOfQuestions
            destinationVC.correctNumber = gameManager.currentUserScore
        }
    }
    
    @objc func showMultiple(){
        DispatchQueue.main.async {
            self.booleanButtonView.isHidden = true
            self.multipleButtonView.isHidden = false
        }
    }
    
    @objc func showBoolean(){
        DispatchQueue.main.async {
            self.booleanButtonView.isHidden = false
            self.multipleButtonView.isHidden = true
        }
    }
}

//MARK: - GameManagerDelegate
extension GameViewController: GameManagerDelegate {
    func updateUI(uiData: UIData) {
        // Update main UI
        DispatchQueue.main.async{
            self.questionLabel.text = uiData.question.htmlAttributedString!.string
            self.questionProgressView.setProgress(uiData.percentage, animated: true)
        }
        
        // Update Button UI and show the correct view
        if uiData.type == "multiple" {
            multipleDelegate?.updateUI(answers: uiData.answers)
            showMultiple()
            //Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showMultiple), userInfo: nil, repeats: false)
            
        } else {
            booleanDelegate?.updateUI(answers: uiData.answers)
            showBoolean()
            //Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showBoolean), userInfo: nil, repeats: false)
        }
        
    }
    
    // Show screen at the end of the game
    func showEndScreen(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.segue.showEndScreen, sender: self)
        }
    }
}

//MARK: - MultipleButtonViewControllerDelegate
// Extension used by two protocols to return data from the button viewcontrollers to the main gameManger instance.
extension GameViewController: MultipleButtonViewControllerDelegate, BooleanButtonViewControllerDelegate {
    func submittedAnswer(answer: String) {
        
        //multipleDelegate?.clearUI()
        gameManager.questionAnswer(answer: answer)
    }
}
