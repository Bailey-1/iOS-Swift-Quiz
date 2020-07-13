//
//  SettingsViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 08/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

class Settings1ViewController: UIViewController {
    
    @IBOutlet weak var stepperValue: UILabel!

    var settingsOptions = SettingsOptions()
    
    @IBOutlet weak var numberOfQuestionsStepper: UIStepper!
    
    let categoriesManager = CategoriesManager()
    var categories: CateogoryData?
    
    override func viewWillAppear(_ animated: Bool) {
        // Always call super when overiding method from the super class
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Always call super when overiding method from the super class
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfQuestionsStepper.value = 10
        settingsOptions.numberOfQuestions = 10
        
        categoriesManager.getCategories()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Color-1")]
    }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        settingsOptions.numberOfQuestions = Int(sender.value)
        stepperValue.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        categories = categoriesManager.categories
        self.performSegue(withIdentifier: K.segue.showSettings2, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.showSettings2 {
            let destinationVC = segue.destination as! Settings2ViewController //Chose the right view controller. - Downcasting
            
            destinationVC.settingsOptions = settingsOptions
            destinationVC.categories = categories
            destinationVC.categoriesManager = categoriesManager
        }
    }
    
    @IBAction func unwindToTwo(_ sender: UIStoryboardSegue){}
}
