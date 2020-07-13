//
//  QuizData.swift
//  TriviaGame
//
//  Created by Bailey Search on 09/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import Foundation

extension String {
    /// Converts HTML string to a `NSAttributedString`

    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}

struct QuizData: Decodable {
    var results: [QuestionData]
}

struct QuestionData: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
