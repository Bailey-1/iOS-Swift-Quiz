//
//  Settings3ViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 08/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

class Settings3ViewController: UIViewController {

    var settingsOptions: SettingsOptions?

    @IBOutlet var allDifficultyButtons : [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let safeSettingsOptions = settingsOptions {
            print(safeSettingsOptions)
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        var questionTypeSelected: String?
        
        switch(sender.selectedSegmentIndex) {
        case 0:
            questionTypeSelected = nil
            break
            
        case 1:
            questionTypeSelected = "boolean"
            break
            
        case 2:
            questionTypeSelected = "multiple"
            break
        default:
            print("ERROR")
        }
        
        settingsOptions?.type = questionTypeSelected
    }
    
    @IBAction func difficultyButtonPressed(_ sender: UIButton) {
        
        for button in allDifficultyButtons {
            button.backgroundColor = UIColor.lightGray
            button.setTitleColor(UIColor.white, for: .normal)
        }
        
        sender.backgroundColor = UIColor.blue
        sender.setTitleColor(UIColor.black, for: .normal)
        
        switch(sender.currentTitle!){
        case "Easy":
            settingsOptions?.difficulty = "easy"
            break
        case "Medium":
            settingsOptions?.difficulty = "medium"
            break
        case "Hard":
            settingsOptions?.difficulty = "hard"
            break
        default:
            settingsOptions?.difficulty = nil
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.segue.showGame, sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.showGame {
            let destinationVC = segue.destination as! GameViewController //Chose the right view controller. - Downcasting
            destinationVC.settingsOptions = settingsOptions
        }
    }
}
