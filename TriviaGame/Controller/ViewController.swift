//
//  ViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 08/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
            
    // Hide navigationbar on the welcome screen
    override func viewWillAppear(_ animated: Bool) {
        // Always call super when overiding method from the super class
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // Unhide the navigation bar to show it on other screens
    override func viewWillDisappear(_ animated: Bool) {
        // Always call super when overiding method from the super class
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: K.segue.showSettings1, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.showSettings1 {
            //let destinationVC = segue.destination as! Settings1ViewController //Chose the right view controller. - Downcasting
            
            //destinationVC.categories = controllerManager.categories
        }
    }
    
    @IBAction func unwindToOne(_ sender: UIStoryboardSegue){}
}

