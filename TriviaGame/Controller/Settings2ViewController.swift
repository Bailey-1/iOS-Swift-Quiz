//
//  Settings2ViewController.swift
//  TriviaGame
//
//  Created by Bailey Search on 08/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import UIKit

class Settings2ViewController: UIViewController {

    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var categoryPickerSelected: UILabel!
    
    @IBOutlet weak var totalLable: UILabel!
    @IBOutlet weak var easyLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    
    
    var settingsOptions: SettingsOptions?
    var categories: CateogoryData?
    var categoriesManager: CategoriesManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        categoriesManager?.delegate = self
        
        categoryPickerSelected.text = categories?.trivia_categories[settingsOptions!.category].name
        print(settingsOptions!)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.segue.showSettings3, sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.showSettings3 {
            let destinationVC = segue.destination as! Settings3ViewController //Chose the right view controller. - Downcasting
            destinationVC.settingsOptions = settingsOptions
        }
    }
}

//MARK: - UIPickerView
extension Settings2ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (categories?.trivia_categories.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories?.trivia_categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = categories?.trivia_categories[row].name
        settingsOptions?.category = categories!.trivia_categories[row].id
        if settingsOptions?.category != 0 {
            categoriesManager!.getCategoriesStats(catId: settingsOptions!.category)
        } else {
            DispatchQueue.main.async {
                self.easyLabel.text = ""
                self.mediumLabel.text = ""
                self.hardLabel.text = ""
            }
        }

        categoryPickerSelected.text = selectedOption

    }
}

extension Settings2ViewController: CategoriesManagerDelegate {
    func updateCategoryStatsLabels() {
        DispatchQueue.main.async {
            self.easyLabel.text = "Easy: \(self.categoriesManager!.categoryStats!.category_question_count.total_easy_question_count)"
            self.mediumLabel.text = "Medium: \(self.categoriesManager!.categoryStats!.category_question_count.total_medium_question_count)"
            self.hardLabel.text = "Hard: \(self.categoriesManager!.categoryStats!.category_question_count.total_hard_question_count)"
        }
    }
}
