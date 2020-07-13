//
//  GameManager.swift
//  TriviaGame
//
//  Created by Bailey Search on 09/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import Foundation

protocol GameManagerDelegate {
    func updateUI(uiData: UIData)
    func showEndScreen()
}

class GameManager {
    
    var delegate: GameManagerDelegate?
    
    var quizData: QuizData?
    
    var settingsOptions: SettingsOptions?
    
    var currentQuestion: QuestionData?
    var currentQuestionNumber: Int = 0
    var currentUserScore: Int = 0
    
    // Fetch API data and start the game
    func fetchQuizData(settingsOptions: SettingsOptions){
        let quizURL = generateURL(settingsOptions: settingsOptions)
        self.settingsOptions = settingsOptions
        
        if let url = URL(string: quizURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(QuizData.self, from: safeData)
                            self.quizData = results
                            //print(results)
                            self.nextQuestion()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    // Show the next question and send data to the view controller
    func nextQuestion(){
        // Check the current number is under the max
        if let safeNumberOfQuestions = settingsOptions?.numberOfQuestions {
            if currentQuestionNumber < safeNumberOfQuestions {
                
                if quizData?.results.count == 0 {
                    delegate?.showEndScreen()
                } else {
                    // Increment the current question
                    currentQuestion = quizData?.results[currentQuestionNumber]
                    if let safeQuestion = currentQuestion?.question {
                        
                        var answerArray: [Answers] // Create answer array
                        
                        // Populate the array based on the number of
                        if currentQuestion?.type == "boolean" {
                            answerArray = [
                                Answers(text: currentQuestion!.correct_answer, correct: true),
                                Answers(text: currentQuestion!.incorrect_answers[0], correct: false),
                            ]
                        } else {
                            answerArray = [
                                Answers(text: currentQuestion!.correct_answer, correct: true),
                                Answers(text: currentQuestion!.incorrect_answers[0], correct: false),
                                Answers(text: currentQuestion!.incorrect_answers[1], correct: false),
                                Answers(text: currentQuestion!.incorrect_answers[2], correct: false),
                            ]
                        }
                        
                        answerArray.shuffle()
                        
                        let questionPercentage = Float(currentQuestionNumber+1) / Float(settingsOptions!.numberOfQuestions)
                        
                        print("Percentage: \(questionPercentage)")
                        
                        let uiData = UIData(question: safeQuestion,
                                            answers: answerArray,
                                            percentage: questionPercentage,
                                            type: currentQuestion!.type)
                        
                        
                        delegate?.updateUI(uiData: uiData)
                        print("QUESTION: \(safeQuestion)")
                    }
                    currentQuestionNumber += 1
                }
                
            } else {
                print("Game Over")
                print("Your score is \(currentUserScore) / \(settingsOptions!.numberOfQuestions)")
                delegate?.showEndScreen()
            }
        }
        
    }
    
    func questionAnswer(answer: String) {
        if let safeIncorrectAnswers = currentQuestion?.incorrect_answers {
            if let safeCorrectAnswer = currentQuestion?.correct_answer {
                if (safeCorrectAnswer == answer || safeIncorrectAnswers.contains(answer)){
                    if answer == safeCorrectAnswer {
                        print("Correct Answer!")
                        currentUserScore += 1
                    } else {
                        print("Wrong Answer")
                    }
                    nextQuestion()
                }
            }
        }
    }
    
    func generateURL(settingsOptions: SettingsOptions) -> String {
        var baseURL = "https://opentdb.com/api.php?"
        
        baseURL += "amount=\(settingsOptions.numberOfQuestions)"
        
        if settingsOptions.category != 0 {
            baseURL += "&category=\(settingsOptions.category)"
        }
        
        if let safeDifficulty = settingsOptions.difficulty {
            baseURL += "&difficulty=\(safeDifficulty)"
        }
        
        if let safeType = settingsOptions.type {
            baseURL += "&type=\(safeType)"
        }
        
        print("BASEURL: \(baseURL)")
        return baseURL
    }
}
